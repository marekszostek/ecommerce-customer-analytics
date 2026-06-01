import os
from pathlib import Path

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine

# Load environment variables
load_dotenv(Path(__file__).resolve().parent.parent / ".env")

# Database credentials
username = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")
database = os.getenv("DB_NAME")

# Database connection
engine = create_engine(
    f"postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}"
)

# Source files
files = {
    "customers": "data/raw/olist_customers_dataset.csv",
    "orders": "data/raw/olist_orders_dataset.csv",
    "products": "data/raw/olist_products_dataset.csv",
    "order_items": "data/raw/olist_order_items_dataset.csv",
    "payments": "data/raw/olist_order_payments_dataset.csv",
    "reviews": "data/raw/olist_order_reviews_dataset.csv",
    "category_translation": "data/raw/product_category_name_translation.csv"
}

# ETL Process
for table_name, file_path in files.items():

    df = pd.read_csv(file_path)

    # Fix column names in Olist dataset
    if table_name == "products":
        df = df.rename(columns={
            "product_name_lenght": "product_name_length",
            "product_description_lenght": "product_description_length"
        })

    df.to_sql(
        name=table_name,
        con=engine,
        if_exists="append",
        index=False
    )

print("ETL process completed successfully.")