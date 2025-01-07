using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SplitBuddy.Api.Models.Api;
using SplitBuddy.Api.Models.Entities;
using SplitBuddy.Api.Services;

namespace SplitBuddy.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentSplitsController(AppDbContext context, IMapper mapper)
    {
        private readonly AppDbContext _context = context;
        private readonly IMapper _mapper = mapper;

        [HttpGet("getPaymentSplit/{paymentSplitId}")]
        public async Task<PaymentSplitsFormVm> GetPaymentSplit(int paymentSplitId)
        {
            var paymentSplit = await _context.PaymentSplits.Include(g=>g.Debtor).Include(g=>g.Payment).Include(g=>g.Payment.Group).Include(g=>g.Payment.Payer).SingleOrDefaultAsync(u=>u.Id == paymentSplitId);
            return _mapper.Map<PaymentSplitsFormVm>(paymentSplit);
        }

    }
}
