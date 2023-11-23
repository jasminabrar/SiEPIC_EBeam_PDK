# run_tests.py
import subprocess
import os

# Set the COVERAGE_PROCESS_START environment variable
os.environ['COVERAGE_PROCESS_START'] = '/home/pymacros/.coveragerc'

# Run your tests with coverage using klayout
try:
    subprocess.run(['coverage', 'run', 'klayout', '-zz', '-r', 'pymacros/EBeam_Lib_PCellTests.py'], check=True)

except subprocess.CalledProcessError as e:
    print(f"Error during test execution: {e}")
    # Print the contents of the KLayout log
    klayout_log_path = '/tmp/klayout.log'
    with open(klayout_log_path, 'r') as log_file:
        print(log_file.read())
    raise  # Re-raise the exception

else:
    print("Tests completed successfully.")

# Generate the coverage report
subprocess.run(['coverage', 'xml', '-o', '/home/pymacros/coverage.xml'], check=True)
