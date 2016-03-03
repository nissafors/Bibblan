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
            Mapper.Initialize(x =>
                {
                    x.CreateMap<Author, AuthorViewModel>();
                    x.CreateMap<Book, BookViewModel>();
                    x.CreateMap<Borrower, BorrowerViewModel>();
                    x.CreateMap<Copy, CopyViewModel>();
                });
        }
    }
}
