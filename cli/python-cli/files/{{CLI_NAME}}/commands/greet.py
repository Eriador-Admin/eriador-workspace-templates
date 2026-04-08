import typer
from rich.console import Console

app = typer.Typer(help="Greet someone by name")
console = Console()

@app.callback(invoke_without_command=True)
def greet(
    name: str = typer.Argument(help="Name to greet"),
    shout: bool = typer.Option(False, "--shout", "-s", help="Greet in uppercase"),
):
    """Say hello to NAME."""
    message = f"Hello, {name}!"
    if shout:
        message = message.upper()
    console.print(f"[green]✔[/green] {message}")
