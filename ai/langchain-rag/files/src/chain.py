import os
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain_community.vectorstores import Chroma
from langchain.chains import RetrievalQA

CHROMA_DIR = os.path.join(os.path.dirname(__file__), "..", "chroma_db")


def get_rag_chain() -> RetrievalQA:
    """Create a RAG chain with ChromaDB retriever and OpenAI LLM."""
    embeddings = OpenAIEmbeddings(
        model=os.getenv("EMBEDDING_MODEL", "{{EMBEDDING_MODEL}}"),
    )

    vectorstore = Chroma(
        persist_directory=CHROMA_DIR,
        embedding_function=embeddings,
    )

    llm = ChatOpenAI(
        model=os.getenv("LLM_MODEL", "{{LLM_MODEL}}"),
        temperature=0,
    )

    chain = RetrievalQA.from_chain_type(
        llm=llm,
        chain_type="stuff",
        retriever=vectorstore.as_retriever(search_kwargs={"k": 4}),
        return_source_documents=True,
    )

    return chain


def query(question: str) -> dict:
    """Run a question through the RAG chain."""
    chain = get_rag_chain()
    result = chain.invoke({"query": question})
    return {
        "answer": result["result"],
        "sources": [
            {"content": doc.page_content, "metadata": doc.metadata}
            for doc in result.get("source_documents", [])
        ],
    }
