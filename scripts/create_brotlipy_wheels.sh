#!/bin/bash
set -x -e

# Exclude Python 2.6 by just...blowing it away.
rm -rf /opt/python/cp26*

for PYBIN in /opt/python/*/bin; do
    ${PYBIN}/pip install cffi enum34
    ${PYBIN}/pip wheel --no-deps brotlipy -w wheelhouse/
done

for whl in wheelhouse/brotlipy*.whl; do
    auditwheel repair $whl -w /build/wheelhouse/
done

for PYBIN in /opt/python/*/bin/; do
    ${PYBIN}/pip install brotlipy --no-index -f /build/wheelhouse
    ${PYBIN}/python -c "import brotli; assert brotli.decompress(b'\x06') == b''"
done
