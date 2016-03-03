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
            Mapper.CreateMap<Author, AuthorViewModel>();
            Mapper.CreateMap<Book, BookViewModel>();
            Mapper.CreateMap<Borrower, BorrowerViewModel>();
            Mapper.CreateMap<Copy, CopyViewModel>();
        }
    }
}
