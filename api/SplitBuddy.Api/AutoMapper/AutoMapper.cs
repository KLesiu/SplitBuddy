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
                .ForMember(d => d.Name, s => s.MapFrom(a => a.Name));

            CreateMap<User, UserFormVm>()
                .ForMember(d => d.Id, s => s.MapFrom(a => a.Id))
                .ForMember(d => d.Role, s => s.MapFrom(a => a.Role))
                .ForMember(d=>d.Email,s=>s.MapFrom(s=>s.Email))
                .ForMember(d => d.Username, s => s.MapFrom(a => a.Username));

            CreateMap<GroupMembership, GroupMembershipFormVm>()
                .ForMember(d => d.Id, s => s.MapFrom(a => a.Id))
                .ForMember(d => d.User, s => s.MapFrom(a => a.User))
                .ForMember(d => d.Group, s => s.MapFrom(s => s.Group));

            CreateMap<PaymentSplits, PaymentSplitsFormVm>()
               .ForMember(d => d.Id, s => s.MapFrom(a => a.Id))
               .ForMember(d => d.Debtor, s => s.MapFrom(s => s.Debtor))
               .ForMember(d => d.PercentageCost, s => s.MapFrom(s => s.PercentageCost))
               .ForMember(d => d.Payment, s => s.MapFrom(s => s.Payment))
               .ForMember(d => d.Cost, s => s.MapFrom(s => s.Cost));

            CreateMap<Payment, PaymentFormVm>()
                .ForMember(d => d.Id, s => s.MapFrom(a => a.Id))
                .ForMember(d => d.Price, s => s.MapFrom(a => a.Price))
                .ForMember(d => d.Currency, s => s.MapFrom(s => s.Currency))
                .ForMember(d => d.DateTime, s => s.MapFrom(s => s.DateTime))
                .ForMember(d => d.Description, s => s.MapFrom(s => s.Description))
                .ForMember(d => d.Payer, s => s.MapFrom(s => s.Payer))
                .ForMember(d => d.Categories, s => s.MapFrom(s => s.Categories))
                .ForMember(d => d.Group, s => s.MapFrom(s => s.Group));


            CreateMap<GroupMembership, GroupFormVm>()
              .ForMember(d => d.Id, s => s.MapFrom(a => a.Group.Id))
              .ForMember(d => d.Name, s => s.MapFrom(a => a.Group.Name));



        }
    }
}
