import streamlit as st
import pandas as pd

st.set_page_config(page_title="Data Explorer", page_icon="🔍")
st.title("🔍 Data Explorer")


@st.cache_data
def load_data():
    return pd.read_csv("data/sample.csv")


df = load_data()

st.subheader("Filter Data")
categories = st.multiselect("Category", options=df["category"].unique(), default=df["category"].unique())
filtered = df[df["category"].isin(categories)]

st.subheader(f"Showing {len(filtered)} rows")
st.dataframe(filtered, use_container_width=True)

st.subheader("Summary Statistics")
st.write(filtered.describe())
