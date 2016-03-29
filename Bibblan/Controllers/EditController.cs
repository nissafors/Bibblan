// TODO:
// * Revise Renew
// * Account

using Bibblan.Filters;
using Bibblan.Helpers;
using Common.Models;
using Services.Exceptions;
using Services.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Bibblan.Controllers
{
    public class EditController : Controller
    {
        /// <summary>
        /// GET: Edit/Book and Edit/Book/{isbn}. Display a form to create or update books.
        /// </summary>
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Book(string isbn)
        {
            var errors = new List<string>();
            var bookInfo = new EditBookViewModel();

            if (isbn != null)
            {
                try
                {
                    bookInfo = BookServices.GetEditBookViewModel(isbn);
                    bookInfo.Update = true;
                }
                catch (DoesNotExistException e) { errors.Add(e.Message); }
                catch (AlreadyExistsException e) { errors.Add(e.Message); }
                catch (DataAccessException e) { errors.Add(e.Message); }
            }

            string err = setBookViewLists(bookInfo);
            if (err != null)
                errors.Add(err);

            if (errors.Count > 0)
                ViewBag.error = errors;

            return View(bookInfo);
        }

        /// <summary>
        /// POST: Edit/Book. Writes bookInfo to database and display the edit book view.
        /// </summary>
        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Book(EditBookViewModel bookInfo)
        {
            string err = setBookViewLists(bookInfo);
            bool upsertSuccess = false;
            if (err != null)
                ViewBag.error = err + "\n";

            if (ModelState.IsValid)
            {
                try
                {
                    BookServices.Upsert(bookInfo, bookInfo.Update);
                    bookInfo.Update = true;
                    upsertSuccess = true;
                }
                catch (AlreadyExistsException e) { ViewBag.error += e.Message; }
                catch (DoesNotExistException e) { ViewBag.error += e.Message; }
                catch (DataAccessException e) { ViewBag.error += e.Message; }
                catch (Exception) { ViewBag.error += "Oväntat fel."; }
            }
            if(!upsertSuccess)
                return View(bookInfo);
            else
                return RedirectToAction("Book", "Search", new { search = bookInfo.ISBN});
        }

        /// <summary>
        /// GET: /Edit/Copy/{isbn}. Show a form to create and update copies of a book.
        /// </summary>
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Copy(string isbn, string barcode)
        {
            var errors = new List<string>();

            // We must have an ISBN number.
            if (isbn == null)
            {
                TempData["error"] = "Kan endast skapa exemplar av existerande böcker.";
                return RedirectToAction("AdminPage", "Account");
            }

            // Is this ISBN valid?
            try
            {
                BookServices.GetBookDetails(isbn);
            }
            catch (DoesNotExistException e)
            {
                TempData["error"] = e.Message;
                return RedirectToAction("AdminPage", "Account");
            }
            catch (DataAccessException e)
            {
                TempData["error"] = e.Message;
                return RedirectToAction("AdminPage", "Account");
            }

            CopyViewModel cvm = new CopyViewModel();

            // If a barcode was given; is it valid?
            if (barcode != null)
            {
                try
                {
                    cvm = CopyServices.GetCopyViewModel(barcode);
                    cvm.Update = true;
                }
                catch (DoesNotExistException e) { errors.Add(e.Message); }
                catch (DataAccessException e) { errors.Add(e.Message); }
            }

            cvm.ISBN = isbn;
            string err = setCopyViewLists(cvm);
            if (err != null)
                errors.Add(err);

            if (errors.Count > 0)
                ViewBag.error = errors;

            return View(cvm);
        }

        /// <summary>
        /// POST: /edit/copy. Save copy to db and redirect to the edit book view.
        /// </summary>
        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Copy(CopyViewModel copyInfo)
        {
            if (!ModelState.IsValid)
            {
                string err = setCopyViewLists(copyInfo);
                if (err != null)
                    ViewBag.error = err;

                return View(copyInfo);
            }

            try
            {
                CopyServices.Upsert(copyInfo, copyInfo.Update);
                return RedirectToAction("Book", new { copyInfo.ISBN });
            }
            catch (Exception e)
            {
                var errors = new List<string>();
                errors.Add(e.Message);
                string err = setCopyViewLists(copyInfo);
                if (err != null)
                    errors.Add("err");

                ViewBag.error = errors;

                return View(copyInfo);
            }

        }

        /// <summary>
        /// GET: /Edit/Borrower. Show form to CRUD borrower.
        /// </summary>
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Borrower(string PersonId)
        {
            var errors = new List<string>();

            BorrowerViewModel borrower = new BorrowerViewModel();
            borrower.New = true;

            if (PersonId != null)
            {
                try
                {
                    borrower = BorrowerServices.GetBorrower(PersonId);
                    borrower.New = false;
                }
                catch (DoesNotExistException e) { errors.Add(e.Message); }
                catch (DataAccessException e) { errors.Add(e.Message); }
            }

            string err = setBorrowerViewLists(borrower);

            if (err != null)
                errors.Add(err);

            if (errors.Count > 0)
                ViewBag.error = errors;

            return View(borrower);
        }

        /// <summary>
        /// POST: /Edit/Borrower. Upsert changes to borrower.
        /// </summary>
        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Borrower(BorrowerViewModel borrower, string password, string passwordRetry)
        {
            var errors = new List<string>();
            string err;
            bool upsertSuccess = false;
            if (ModelState.IsValid)
            {
                try
                {
                    BorrowerServices.Upsert(borrower);
                    borrower = BorrowerServices.GetBorrower(borrower.PersonId);
                    borrower.New = false;
                    upsertSuccess = true;
                }
                catch (AlreadyExistsException e)
                {
                    errors.Add(e.Message);
                }
                catch (DoesNotExistException e)
                {
                    errors.Add(e.Message);
                }
                catch (DataAccessException e)
                {
                    errors.Add(e.Message);
                }
            }
            
            err = setBorrowerViewLists(borrower);
            if (err != null)
                errors.Add(err);

            if (errors.Count > 0)
                ViewBag.error = errors;

            if (!upsertSuccess)
                return View(borrower);
            else
                return RedirectToAction("Borrower", "Search", new { search = borrower.PersonId });
        }

        [RequireLogin(RequiredRole = AccountHelper.Role.User, ForceCheck = true)]
        public ActionResult Renew(BorrowViewModel borrowViewModel)
        {
            try
            { 
                BorrowServices.Renew(borrowViewModel);
            }
            catch(DoesNotExistException e) { ViewBag.error = e.Message; }
            catch(DataAccessException e) { ViewBag.error = e.Message; }

            if (Request.UrlReferrer != null)
            {
                return Redirect(Request.UrlReferrer.ToString());
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        /// <summary>
        /// GET: /Edit/Delete/{Type}/{Id}. Delete a resource of type Type identified by Id.
        /// </summary>
        /// <remarks>
        /// Different Type:s redirects to different places. Most uses /home/index as a fallback on error.</remarks>
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Delete(string Type, string Id)
        {
            try
            {
                Type = Type.ToLower();
                switch (Type)
                {
                    case "borrower":
                        BorrowerServices.Delete(Id);
                        return RedirectToAction("Borrower", "Search");

                    case "author":
                        AuthorServices.DeleteAuthor(Id);
                        return RedirectToAction("Author", "Search");

                    case "book":
                        BookServices.Delete(Id);
                        return RedirectToAction("Book", "Search");

                    case "copy":
                        bool isbnFound;
                        string isbn = "";
                        try
                        {
                            isbn = CopyServices.GetCopyViewModel(Id).ISBN;
                            isbnFound = true;
                        }
                        catch (DoesNotExistException) { isbnFound = false; }
                        catch (DataAccessException) { isbnFound = false; }
                        
                        CopyServices.DeleteCopy(Id);

                        if (!isbnFound)
                        {
                            TempData["error"] = "Hittar inte tillbaka till boken som ett exemplar av raderades.";
                            return RedirectToAction("Index", "Home");
                        }

                        return RedirectToAction("Book", new { isbn });

                    case "account":
                        if (AccountHelper.GetUserName(Session) == Id)
                            throw new DeleteException("Kan inte ta bort inloggad användare");
                        AccountServices.Delete(new AccountViewModel() { Username = Id });
                        return RedirectToAction("Account");

                    default:
                        return RedirectToAction("Index", "Home");

                }
            }
            catch (DeleteException e)
            {
                TempData["error"] = e.Message;

                if (Request.UrlReferrer != null)
                {
                    return Redirect(Request.UrlReferrer.ToString());
                }
                else
                {
                    return RedirectToAction("Index", "Home");
                }
            }
            catch (DoesNotExistException e)
            {
                TempData["error"] = e.Message;
            }
            catch (DataAccessException e)
            {
                TempData["error"] = e.Message;
            }
            catch (Exception)
            {
                TempData["error"] = "Ett oväntat fel uppstod när ett objekt skulle tas bort.";
            }

                return RedirectToAction("Index", "Home");
            }

        /// <summary>
        /// GET: /Edit/Author. Show form to CRUD authors.
        /// </summary>
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin)]
        public ActionResult Author(int? authorid)
        {
            AuthorViewModel author = new AuthorViewModel();

            if (TempData["error"] != null)
            {
                ViewBag.error = TempData["error"].ToString();
                TempData["error"] = null;
            }

            try
            {
                if (authorid != null)
                {
                    author = AuthorServices.GetAuthor((int)authorid);
                }
            }
            catch (DoesNotExistException e) { ViewBag.error = e.Message; }
            catch (DataAccessException e) { ViewBag.error = e.Message; }

            return View(author);
        }

        /// <summary>
        /// POST: /Edit/Author. Upsert changes to author and return to view.
        /// </summary>
        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Author(AuthorViewModel authorViewModel)
        {
            bool updateSuccess = false;
            if (ModelState.IsValid)
            {
                try
                {
                    AuthorServices.Upsert(authorViewModel);
                    updateSuccess = true;
                }
                catch (DataAccessException e)
                {
                    ViewBag.error = e.Message;
                    return View(authorViewModel);
                }
                catch (DoesNotExistException e)
                {
                    ViewBag.error = e.Message;
                    return View(authorViewModel);
                }
            }

            if (updateSuccess)
                return RedirectToAction("Author", "Search", new { search = authorViewModel.FirstName + " " + authorViewModel.LastName });
            else
                return View(authorViewModel);
        }

        /// <summary>
        /// Does an upsert for an Account if the user session has admin privligies
        /// GET: /Edit/Account
        /// </summary>
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Account(string username)
        {
            getAccountList();
            AccountViewModel viewModel = new AccountViewModel() { Username = username, New = true };

            if(username != null)
            {
                if(AccountHelper.GetUserName(Session) == username)
                    ViewBag.currentUser = true;

                try
                {
                    if (AccountServices.AccountExists(username))
                    {
                        viewModel.New = false;
                    }
                }
                catch (DataAccessException e)
                {
                        ViewBag.error = e.Message;
                }
                
            }
            return View(viewModel);
        }

        /// <summary>
        /// Does an upsert for an Account if the user has session privligies
        /// POST: /Edit/Account
        /// </summary>
        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.Admin, ForceCheck = true)]
        public ActionResult Account(AccountViewModel model)
        {
            if (AccountHelper.GetUserName(Session) == model.Username)
                ViewBag.currentUser = true;
            
                try
                {
                    if (model.NewPassword != null &&
                        model.Username != null &&
                        ModelState.IsValid &&
                        !(AccountServices.AccountExists(model.Username) && model.New))
                    {
                        AccountServices.Upsert(model);
                        model.New = false;
                    }
                    else if((AccountServices.AccountExists(model.Username) && model.New))
                    {
                        ViewBag.error = "Kan inte lägga lägga till existerande användare";
                    }
                }
                catch (DataAccessException e)
                {
                    ViewBag.error = e.Message;
                }


            getAccountList();
            return View(model);
        }

        /// <summary>
        /// GET: /Edit/ChangePassword/{Username}. Change the password for user
        /// </summary>
        [HttpGet]
        [RequireLogin(RequiredRole = AccountHelper.Role.User)]
        public ActionResult ChangePassword()
        {
            AccountViewModel viewModel = new AccountViewModel();
            viewModel.Username = AccountHelper.GetUserName(this.Session);
            return View(viewModel);
        }

        [HttpPost]
        [RequireLogin(RequiredRole = AccountHelper.Role.User, ForceCheck = true)]
        public ActionResult ChangePassword(AccountViewModel viewModel)
        {
            bool succesfull = false;
            try
            {
                if (ModelState.IsValid)
                {
                    AccountServices.Login(viewModel); //Throws error if login failed
                    AccountServices.Upsert(viewModel);
                    succesfull = true;
                }
            }
            catch (DataAccessException)
            {
                ViewBag.error = "Kunde inte byta lösenord";
            }
            catch (DoesNotExistException)
            {
                ViewBag.error = "Kunde inte byta lösenord";
            }

            if(succesfull)
                return RedirectToAction("UserPage", "Account");
            else
                return View(viewModel);
        }

        /// <summary>
        /// Populate lists in an EditBookViewModel.
        /// </summary>
        /// <param name="ebvm">The EditBookViewModel.</param>
        /// <returns>Returns an error message or null, if no error occured.</returns>
        private string setBookViewLists(EditBookViewModel ebvm)
        {
            try
            {
                if (ebvm.ISBN != null)
                    ebvm.Copies = CopyServices.getCopyViewModels(ebvm.ISBN);

                var classDic = ClassificationServices.GetClassificationsAsDictionary();
                var authorDic = AuthorServices.GetAuthorsAsDictionary();
                ebvm.Classifications = new SelectList(classDic.OrderBy(x => x.Value), "Key", "Value");
                ebvm.Authors = new SelectList(authorDic.OrderBy(x => x.Value), "Key", "Value");
            }
            catch (DataAccessException e)
            {
                if (ebvm.Copies == null) ebvm.Copies = new List<CopyViewModel>();
                if (ebvm.Classifications == null) ebvm.Classifications = new SelectList(new List<SelectListItem>());
                if (ebvm.Authors == null) ebvm.Authors = new SelectList(new List<SelectListItem>());
                return e.Message;
            }

            return null;
        }

        /// <summary>
        /// Populate Statuses and Title in a CopyViewModel.
        /// </summary>
        /// <param name="cvm">The CopyViewModel.</param>
        /// <returns>Returns an error message or null, if no error occured.</returns>
        private string setCopyViewLists(CopyViewModel cvm)
        {
            try
            {
                var statusDic = StatusServices.GetStatusesAsDictionary();
                cvm.Title = BookServices.GetBookDetails(cvm.ISBN).Title;
                cvm.Statuses = new SelectList(statusDic.OrderBy(x => x.Value), "Key", "Value");
            }
            catch (DataAccessException e)
            {
                if (cvm.Title == null)
                    cvm.Title = "";
                if (cvm.Statuses == null)
                    cvm.Statuses = new SelectList(new List<SelectListItem>());
                return e.Message;
            }

            return null;
        }

        /// <summary>
        /// Populate selectlists in /edit/borrower.
        /// </summary>
        private string setBorrowerViewLists(BorrowerViewModel borrower)
        {
            try
            {
                var categoryDic = CategoryServices.GetCategoriesAsDictionary();
                borrower.Category = new SelectList(categoryDic.OrderBy(x => x.Value), "Key", "Value");
            }
            catch (DataAccessException e)
            {
                borrower.Category = new SelectList(new List<SelectListItem>());
                return e.Message;
            }
            return null;
        }

        /// <summary>
        /// Fill ViewBag.accounts with a list of Account viewmodels
        /// </summary>
        /// <returns></returns>
        private void getAccountList()
        {
            try
            {
                ViewBag.accounts = AccountServices.GetAccounts((int)AccountHelper.Role.Admin);
            }
            catch (DataAccessException e)
            {
                ViewBag.error = e.Message;
                ViewBag.accounts = new List<AccountViewModel>();
            }
        }
    }
}