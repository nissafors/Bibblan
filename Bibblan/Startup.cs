using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Bibblan.Startup))]
namespace Bibblan
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
