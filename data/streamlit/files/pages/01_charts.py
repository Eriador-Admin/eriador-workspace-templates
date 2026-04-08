import streamlit as st
import pandas as pd
import plotly.express as px

st.set_page_config(page_title="Charts", page_icon="📈")
st.title("📈 Charts")


@st.cache_data
def load_data():
    return pd.read_csv("data/sample.csv")


df = load_data()

st.subheader("Sales by Category")
fig_bar = px.bar(df, x="category", y="sales", color="category", title="Sales by Category")
st.plotly_chart(fig_bar, use_container_width=True)

st.subheader("Sales Over Time")
fig_line = px.line(df, x="date", y="sales", color="category", title="Sales Trend")
st.plotly_chart(fig_line, use_container_width=True)

st.subheader("Distribution")
fig_hist = px.histogram(df, x="sales", nbins=20, title="Sales Distribution")
st.plotly_chart(fig_hist, use_container_width=True)
