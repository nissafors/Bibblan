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
                    mapping.CreateMap<Book, BookViewModel>();
                    mapping.CreateMap<Borrower, BorrowerViewModel>();
                    mapping.CreateMap<Copy, CopyViewModel>();
                    mapping.CreateMap<CopyViewModel, Copy>();
                    mapping.CreateMap<Book, EditBookViewModel>()
                        .ForMember(c => c.ClassificationId, op => op.MapFrom(v => v.SignId));
                    mapping.CreateMap<EditBookViewModel, Book>()
                        .ForMember(c => c.SignId, op => op.MapFrom(v => v.ClassificationId));
                    mapping.CreateMap<Account, AccountViewModel>();
                });
        }
    }
}
