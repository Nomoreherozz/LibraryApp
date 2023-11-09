using Microsoft.AspNetCore.Session;
using Microsoft.Extensions.Caching.Memory;
namespace PE2023test

{
    public class Startup
    {
        public void Configure(IApplicationBuilder app)
        {
            app.UseCors("Allow_All_AWS_Policy");
            app.UseSession();
            app.UseMvc(routes =>
              {
                  routes.MapRoute(
                      name: "default",
                      template: "{controller=Home}/{action=BookIndex}/{id?}");
              });
        }
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors(o => o.AddPolicy("Allow_All_AWS_Policy", builder =>
            {
                builder
                    .AllowAnyMethod()
                    .AllowAnyHeader();
            }));

            services.AddMvc();
            services.AddDistributedMemoryCache();
            services.AddSession(options => {
                options.IdleTimeout = TimeSpan.FromMinutes(60);
                options.Cookie.IsEssential = true;
                options.Cookie.HttpOnly = true;

            });
        }
    }
}
