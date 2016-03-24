using Bibblan.Helpers;
using Common.Models;
using Services.Exceptions;
using Services.Services;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class BookController : Controller
    {
        /// <summary>
        /// GET: /Book/Details/{isbn}. Show details about a book.
        /// </summary>
        public ActionResult Details(string isbn = "")
        {
            BookViewModel viewModel = null;

            try
            {
                if (AccountHelper.HasAccess(this.Session, AccountHelper.Role.Admin))
                    ViewBag.isAdmin = true;
                else
                    ViewBag.isAdmin = false;

                viewModel = BookServices.GetBookDetails(isbn);
            }
            catch(DataAccessException e)
            {
                ViewBag.error = e.Message;
            }
            catch(DoesNotExistException e)
            {
                ViewBag.error = e.Message;
            }
            
            return View(viewModel);
        }
    }
}