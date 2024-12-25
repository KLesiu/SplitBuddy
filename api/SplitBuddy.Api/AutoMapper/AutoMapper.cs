using AutoMapper;
using SplitBuddy.Api.Models.Entities;
using SplitBuddy.Api.Models.Api;

namespace SplitBuddy.Api.AutoMapper
{
    public class AutoMapper : Profile
    {
        public AutoMapper()
        {
            CreateMap<Group, GroupFormVm>()
                .ForMember(d => d.Id, s => s.MapFrom(a => a.Id))
                .ForMember(d => d.Name, s => s.MapFrom(a => a.Name))
                .ForMember(d => d.Owner, s => s.MapFrom(a => a.Owner));


            CreateMap<User, User>()
                .ForMember(d => d.PasswordHash, d => d.Ignore());


        }
    }
}
