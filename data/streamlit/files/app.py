import streamlit as st
import pandas as pd

st.set_page_config(
    page_title="{{PROJECT_NAME}}",
    page_icon="📊",
    layout="wide",
)

st.title("📊 {{PROJECT_NAME}}")
st.markdown("Welcome to your Streamlit dashboard. Use the sidebar to navigate.")


@st.cache_data
def load_data():
    return pd.read_csv("data/sample.csv")


df = load_data()

col1, col2, col3 = st.columns(3)
col1.metric("Total Rows", len(df))
col2.metric("Columns", len(df.columns))
col3.metric("Avg Sales", f"${df['sales'].mean():,.2f}")

st.subheader("Quick Overview")
st.dataframe(df.head(10), use_container_width=True)
