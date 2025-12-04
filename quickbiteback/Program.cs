

using quickbiteback.Models;

namespace quickbiteback
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddDbContext<QuickBiteDbContext>();
            // Add services to the container.

            builder.Services.AddControllers();

            // CORS
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("QuickbiteCors", policy =>
                {
                    policy
                        .WithOrigins("http://localhost:3000") // React app
                        .AllowAnyHeader()
                        .AllowAnyMethod();
                });
            });

            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }


            app.UseCors("QuickbiteCors");
            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}