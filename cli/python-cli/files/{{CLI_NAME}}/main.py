import typer
from {{CLI_NAME}}.commands import greet

app = typer.Typer(help="{{CLI_DESCRIPTION}}")
app.add_typer(greet.app, name="greet")

if __name__ == "__main__":
    app()
