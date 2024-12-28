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

            CreateMap<User, UserFormVm>()
                .ForMember(d => d.Id, s => s.MapFrom(a => a.Id))
                .ForMember(d => d.Role, s => s.MapFrom(a => a.Role))
                .ForMember(d => d.Username, s => s.MapFrom(a => a.Username));

            CreateMap<GroupMembership, GroupMembershipFormVm>()
                .ForMember(d => d.Id, s => s.MapFrom(a => a.Id))
                .ForMember(d => d.User, s => s.MapFrom(a => a.User))
                .ForMember(d => d.Group, s => s.MapFrom(s => s.Group));
        }
    }
}
