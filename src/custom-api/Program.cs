var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Forces the application to listen on port 80 since it was not working by default
builder.WebHost.UseUrls("http://+:80");

app.MapGet("/", () => "Hello World!");
app.MapGet("/message", () => "Hey Joao, Marcio & Diego, good afternoon!!!");

app.Run();
