# run_tests.py
import subprocess
import os

# Set the COVERAGE_PROCESS_START environment variable
os.environ['COVERAGE_PROCESS_START'] = '/home/pymacros/.coveragerc'

# Run your tests with coverage using klayout
subprocess.run(['klayout', '-zz', '-r', 'pymacros/EBeam_Lib_PCellTests.py'], check=True)

# Generate the coverage report
subprocess.run(['coverage', 'xml', '-o', '/home/pymacros/coverage.xml'], check=True)
