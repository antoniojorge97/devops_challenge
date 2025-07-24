var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello World!");
app.MapGet("/message", () => "Hey Joao, Marcio & Diego!");

app.Run();
