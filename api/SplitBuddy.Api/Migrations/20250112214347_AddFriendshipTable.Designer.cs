﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using SplitBuddy.Api.Services;

#nullable disable

namespace SplitBuddy.Api.Migrations
{
    [DbContext(typeof(AppDbContext))]
    [Migration("20250112214347_AddFriendshipTable")]
    partial class AddFriendshipTable
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "9.0.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.Friendship", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<int>("FriendId")
                        .HasColumnType("integer");

                    b.Property<int>("UserId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("FriendId");

                    b.HasIndex("UserId");

                    b.ToTable("Friendships");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.Group", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("OwnerId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("OwnerId");

                    b.ToTable("Groups");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.GroupMembership", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<int>("GroupId")
                        .HasColumnType("integer");

                    b.Property<int>("UserId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.HasIndex("UserId");

                    b.ToTable("GroupMembership");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.Payment", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.PrimitiveCollection<int[]>("Categories")
                        .HasColumnType("integer[]");

                    b.Property<int>("Currency")
                        .HasColumnType("integer");

                    b.Property<DateTime>("DateTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<int>("GroupId")
                        .HasColumnType("integer");

                    b.Property<int>("PayerId")
                        .HasColumnType("integer");

                    b.Property<decimal>("Price")
                        .HasColumnType("numeric");

                    b.HasKey("Id");

                    b.HasIndex("GroupId");

                    b.HasIndex("PayerId");

                    b.ToTable("Payments");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.PaymentSplits", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<decimal>("Cost")
                        .HasColumnType("numeric");

                    b.Property<int>("DebtorId")
                        .HasColumnType("integer");

                    b.Property<int>("PaymentId")
                        .HasColumnType("integer");

                    b.Property<decimal>("PercentageCost")
                        .HasColumnType("numeric");

                    b.HasKey("Id");

                    b.HasIndex("DebtorId");

                    b.HasIndex("PaymentId");

                    b.ToTable("PaymentSplits");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("PasswordHash")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Role")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.Friendship", b =>
                {
                    b.HasOne("SplitBuddy.Api.Models.Entities.User", "Friend")
                        .WithMany()
                        .HasForeignKey("FriendId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SplitBuddy.Api.Models.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Friend");

                    b.Navigation("User");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.Group", b =>
                {
                    b.HasOne("SplitBuddy.Api.Models.Entities.User", "Owner")
                        .WithMany()
                        .HasForeignKey("OwnerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Owner");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.GroupMembership", b =>
                {
                    b.HasOne("SplitBuddy.Api.Models.Entities.Group", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SplitBuddy.Api.Models.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Group");

                    b.Navigation("User");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.Payment", b =>
                {
                    b.HasOne("SplitBuddy.Api.Models.Entities.Group", "Group")
                        .WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SplitBuddy.Api.Models.Entities.User", "Payer")
                        .WithMany()
                        .HasForeignKey("PayerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Group");

                    b.Navigation("Payer");
                });

            modelBuilder.Entity("SplitBuddy.Api.Models.Entities.PaymentSplits", b =>
                {
                    b.HasOne("SplitBuddy.Api.Models.Entities.User", "Debtor")
                        .WithMany()
                        .HasForeignKey("DebtorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SplitBuddy.Api.Models.Entities.Payment", "Payment")
                        .WithMany()
                        .HasForeignKey("PaymentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Debtor");

                    b.Navigation("Payment");
                });
#pragma warning restore 612, 618
        }
    }
}
