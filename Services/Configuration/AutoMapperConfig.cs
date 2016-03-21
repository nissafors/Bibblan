using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Common.Models;
using Repository.EntityModels;

namespace Services.Configuration
{
    public static class AutoMapperConfig
    {
        public static void Configure()
        {
            Mapper.Initialize(mapping =>
                {
                    mapping.CreateMap<Author, AuthorViewModel>();
                    mapping.CreateMap<AuthorViewModel, Author>();
                    mapping.CreateMap<Book, BookViewModel>();
                    mapping.CreateMap<BookViewModel, Book>();
                    mapping.CreateMap<Borrower, BorrowerViewModel>();
                    mapping.CreateMap<BorrowerViewModel, Borrower>();
                    mapping.CreateMap<Borrow, BorrowViewModel>();
                    mapping.CreateMap<BorrowViewModel, Borrow>();
                    mapping.CreateMap<Copy, CopyViewModel>();
                    mapping.CreateMap<CopyViewModel, Copy>();
                    mapping.CreateMap<Book, EditBookViewModel>()
                        .ForMember(c => c.ClassificationId, op => op.MapFrom(v => v.SignId));
                    mapping.CreateMap<EditBookViewModel, Book>()
                        .ForMember(c => c.SignId, op => op.MapFrom(v => v.ClassificationId));
                    mapping.CreateMap<Account, AccountViewModel>();
                    mapping.CreateMap<AccountViewModel, Account>();
                    mapping.CreateMap<UserRole, RoleViewModel>();
                    mapping.CreateMap<BorrowerViewModel, AccountViewModel>()
                        .ForMember(c => c.BorrowerId, op => op.MapFrom(v => v.PersonId))
                        .ForMember(c => c.Username, op => op.MapFrom(v => v.PersonId))
                        .ForMember(c => c.Password, op => op.MapFrom(v => v.Account.NewPassword))
                        .ForMember(c => c.RoleId, op => op.UseValue(1));
                });
        }
    }
}
