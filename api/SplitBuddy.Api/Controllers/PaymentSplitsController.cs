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
    public class PaymentSplitsController
    {
        private readonly AppDbContext _context;
        private readonly IMapper _mapper;


        public PaymentSplitsController(AppDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }

        [HttpGet("/getPaymentSplit/{paymentSplitId}")]
        public async Task<PaymentSplitsFormVm> GetPaymentSplit(int paymentSplitId)
        {
            var paymentSplit = await _context.PaymentSplits.Include(g=>g.Debtor).Include(g=>g.Payment).SingleOrDefaultAsync(u=>u.Id == paymentSplitId);
            return _mapper.Map<PaymentSplitsFormVm>(paymentSplit);
        }

    }
}
