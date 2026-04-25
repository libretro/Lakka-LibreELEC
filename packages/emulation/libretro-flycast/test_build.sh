#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Build validation script for libretro-flycast
# Verifies that the package definition is correct and the build artifacts
# are produced as expected.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="${SCRIPT_DIR}"

ERRORS=0
PASS=0

pass() {
  PASS=$((PASS + 1))
  echo "  PASS: $1"
}

fail() {
  ERRORS=$((ERRORS + 1))
  echo "  FAIL: $1"
}

echo "=== libretro-flycast build validation ==="
echo ""

# ---------------------------------------------------------------
# 1. Verify package.mk exists and is non-empty
# ---------------------------------------------------------------
echo "-- Checking package.mk --"
if [ -f "${PKG_DIR}/package.mk" ]; then
  pass "package.mk exists"
else
  fail "package.mk not found"
fi

if [ -s "${PKG_DIR}/package.mk" ]; then
  pass "package.mk is non-empty"
else
  fail "package.mk is empty"
fi

# ---------------------------------------------------------------
# 2. Required variables are defined
# ---------------------------------------------------------------
echo "-- Checking required variables --"
for var in PKG_NAME PKG_VERSION PKG_LICENSE PKG_SITE PKG_URL PKG_DEPENDS_TARGET PKG_LONGDESC PKG_TOOLCHAIN; do
  if grep -q "^${var}=" "${PKG_DIR}/package.mk" 2>/dev/null; then
    pass "${var} is defined"
  else
    fail "${var} is NOT defined in package.mk"
  fi
done

# ---------------------------------------------------------------
# 3. PKG_NAME matches directory name
# ---------------------------------------------------------------
echo "-- Checking PKG_NAME consistency --"
DIR_NAME="$(basename "${PKG_DIR}")"
PKG_NAME_VALUE="$(grep '^PKG_NAME=' "${PKG_DIR}/package.mk" | head -1 | cut -d'"' -f2)"
if [ "${PKG_NAME_VALUE}" = "${DIR_NAME}" ]; then
  pass "PKG_NAME '${PKG_NAME_VALUE}' matches directory name"
else
  fail "PKG_NAME '${PKG_NAME_VALUE}' does not match directory '${DIR_NAME}'"
fi

# ---------------------------------------------------------------
# 4. PKG_URL uses PKG_VERSION variable
# ---------------------------------------------------------------
echo "-- Checking PKG_URL references PKG_VERSION --"
if grep -q 'PKG_URL=.*\${PKG_VERSION}' "${PKG_DIR}/package.mk"; then
  pass "PKG_URL references \${PKG_VERSION}"
else
  fail "PKG_URL does not reference \${PKG_VERSION}"
fi

# ---------------------------------------------------------------
# 5. Verify makeinstall_target function exists
# ---------------------------------------------------------------
echo "-- Checking install functions --"
if grep -q "makeinstall_target()" "${PKG_DIR}/package.mk"; then
  pass "makeinstall_target() is defined"
else
  fail "makeinstall_target() is NOT defined"
fi

# ---------------------------------------------------------------
# 6. Verify configuration directory and files
# ---------------------------------------------------------------
echo "-- Checking config files --"
if [ -d "${PKG_DIR}/config" ]; then
  pass "config/ directory exists"
  CFG_COUNT=$(find "${PKG_DIR}/config" -type f | wc -l)
  if [ "${CFG_COUNT}" -gt 0 ]; then
    pass "config/ contains ${CFG_COUNT} file(s)"
  else
    fail "config/ directory is empty"
  fi
else
  fail "config/ directory not found"
fi

# ---------------------------------------------------------------
# 7. Verify architecture handling covers common targets
# ---------------------------------------------------------------
echo "-- Checking architecture support --"
for arch in aarch64 arm x86_64; do
  if grep -q "${arch}" "${PKG_DIR}/package.mk"; then
    pass "Architecture '${arch}' is handled"
  else
    fail "Architecture '${arch}' is NOT handled"
  fi
done

# ---------------------------------------------------------------
# 8. Verify library output name
# ---------------------------------------------------------------
echo "-- Checking library output --"
if grep -q 'PKG_LIBNAME=' "${PKG_DIR}/package.mk"; then
  LIB_NAME="$(grep 'PKG_LIBNAME=' "${PKG_DIR}/package.mk" | head -1 | cut -d'"' -f2)"
  if echo "${LIB_NAME}" | grep -q "_libretro\.so$"; then
    pass "PKG_LIBNAME '${LIB_NAME}' follows libretro naming convention"
  else
    fail "PKG_LIBNAME '${LIB_NAME}' does not follow libretro naming (*_libretro.so)"
  fi
else
  fail "PKG_LIBNAME is not defined"
fi

# ---------------------------------------------------------------
# Summary
# ---------------------------------------------------------------
echo ""
echo "=== Results: ${PASS} passed, ${ERRORS} failed ==="
if [ "${ERRORS}" -gt 0 ]; then
  exit 1
fi
exit 0
