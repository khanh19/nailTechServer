import os
import argparse
from dotenv import load_dotenv
from pathlib import Path

def run_migration():

    dotenv_path = Path('../.env')
    load_dotenv(dotenv_path)

    username = os.getenv('DB_USER')
    password = os.getenv('DB_PASSWORD')
    host = os.getenv('DB_HOST')  # Assuming default is localhost
    port = os.getenv('DB_PORT', '5432')       # Default port for PostgreSQL is 5432
    dbname = os.getenv('DB_NAME')             # Name of the database you want to run commands against
    default_filename = 'create-db.sql'

    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--source", help="file to source", required=False, default=default_filename)
    parser.add_argument("-u", "--user", help="database user", required=False, default=username)
    parser.add_argument("-p", "--password", help="database user's password", required=False, default=password)
    parser.add_argument("-d", "--dbname", help="database name", required=False, default=dbname)
    parser.add_argument("-H", "--host", help="database host", required=False, default=host)
    parser.add_argument("--port", help="database port", required=False, default=port)
    argument = parser.parse_args()

    # psql uses the PGPASSWORD environment variable to use a password without interactive prompt
    os.environ["PGPASSWORD"] = argument.password

    command = f'psql -h {argument.host} -p {argument.port} -U {argument.user} -d {argument.dbname} -a -f {argument.source}'
    os.system(command)


if __name__ == '__main__':
    run_migration()
