#!/usr/bin/env python3
import subprocess
import os

# Set the COVERAGE_PROCESS_START environment variable
os.environ['COVERAGE_PROCESS_START'] = '/home/pymacros/.coveragerc'

# Run your tests with coverage using klayout
try:
    subprocess.run(['/usr/bin/klayout', '-zz', '/home/pymacros/EBeam_Lib_PCellTests.py'], check=True)
except subprocess.CalledProcessError as e:
    print(f"Error during test execution: {e}")
    raise  # Re-raise the exception
else:
    print("Tests completed successfully.")

# Generate the coverage report
subprocess.run(['coverage', 'xml', '-o', '/home/pymacros/coverage.xml'], check=True)
