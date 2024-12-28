using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SplitBuddy.Api.Models.Api;
using SplitBuddy.Api.Models.Entities;
using SplitBuddy.Api.Services;

namespace SplitBuddy.Api.Controllers
{

    public class PaymentController
    {
        private readonly AppDbContext _context;
        private readonly IMapper _mapper;
        private readonly PaymentSplitsController _paymentSplitsController;


        public PaymentController(AppDbContext context, IMapper mapper, PaymentSplitsController paymentSplitsController)
        {
            _context = context;
            _mapper = mapper;
            _paymentSplitsController = paymentSplitsController;

        }

        [HttpGet("/getPayment/{paymentId}")]
        public async Task<PaymentFormVm> Get(int paymentId)
        {
            var payment =  await _context.Payments.Include(g=>g.Payer).Include(g=>g.Group).SingleOrDefaultAsync(u=>u.Id == paymentId); 
            return _mapper.Map<PaymentFormVm>(payment);
        }

        [HttpPost("createPaymentInsideGroup")]
        public async Task<int?> CreatePaymentInsideGroup([FromBody] PaymentVm form)
        {
            var user = await _context.Users.SingleOrDefaultAsync(s=>s.Id == form.PayerId);
            if (user is null) return null;
            var group = await _context.Groups.SingleOrDefaultAsync(s => s.Id == form.GroupId);
            if(group is null) return null;  
            var newPayment = new Payment { Currency = form.Currency,Price=form.Price,DateTime=form.DateTime,Description=form.Description,Payer= user,Categories=form.Categories,Group=group };
            _context.Payments.Add(newPayment);
            await _context.SaveChangesAsync();
            form.PaymentSplits.ForEach(async paymentSplitPart =>
            {
                var debtor = await _context.Users.SingleOrDefaultAsync(s => s.Id == paymentSplitPart.DebtorId);
                if(debtor is null) return;

                var paymentSplit = new PaymentSplits { Cost = paymentSplitPart.Cost, Payment = newPayment, Debtor = debtor, PercentageCost = paymentSplitPart.PercentageCost };
                await _paymentSplitsController.CreatePaymentSplit(paymentSplit);
            });
            return newPayment.Id;

        }

        private async Task<int> CreatePayment(Payment form)
        {
            _context.Payments.Add(form);
            await _context.SaveChangesAsync();
            return form.Id;
        }
    }


}
