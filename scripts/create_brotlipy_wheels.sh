#!/bin/bash
set -x -e

for PYBIN in /opt/python/*/bin; do
    ${PYBIN}/pip install cffi
    ${PYBIN}/pip wheel --no-deps brotlipy -w wheelhouse/
done

for whl in wheelhouse/brotlipy*.whl; do
    auditwheel repair $whl -w /build/wheelhouse/
done

for PYBIN in /opt/python/*/bin/; do
    ${PYBIN}/pip install brotlipy --no-index -f /build/wheelhouse
    ${PYBIN}/python -c "import brotli; assert brotli.decompress(b'\x06') == b''"
done
