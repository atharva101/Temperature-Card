using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace XenparkBlankTemplate.Entity
{
    public partial class XPDbContext : DbContext
    {
        public XPDbContext()
        {
        }

        public XPDbContext(DbContextOptions<XPDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BatchConfiguration> BatchConfiguration { get; set; }
        public virtual DbSet<BatchLog> BatchLog { get; set; }
        public virtual DbSet<ColorCodes> ColorCodes { get; set; }

        public virtual DbSet<ErrorLog> ErrorLog { get; set; }
        public virtual DbSet<LoginInfo> LoginInfo { get; set; }
        public virtual DbSet<MachineLog> MachineLog { get; set; }
        public virtual DbSet<MachineMaster> MachineMaster { get; set; }
        public virtual DbSet<MachineOnOff> MachineOnOff { get; set; }
        public virtual DbSet<ProductMaster> ProductMaster { get; set; }
        public virtual DbSet<User> User { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BatchConfiguration>(entity =>
            {
                entity.Property(e => e.BatchNumber)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Rejection).HasDefaultValueSql("((0))");

                entity.Property(e => e.SetEfficiency).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.SetProduction).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.SetUtilization).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.TargetTime).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.ActualRawMaterialConsumption).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.ActualOilConsumption).HasColumnType("decimal(18, 2)");
                entity.Property(e => e.ActualGasConsumption).HasColumnType("decimal(18, 2)");
                entity.Property(e => e.ActualWaterConsumption).HasColumnType("decimal(18, 2)");
                entity.Property(e => e.ActualPowerConsumption).HasColumnType("decimal(18, 2)");


            });

            modelBuilder.Entity<BatchLog>(entity =>
            {
                entity.Property(e => e.BatchNumber)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Data)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.DowntimeReason)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Shift)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.TimeStamp).HasColumnType("datetime");

                entity.Property(e => e.Topic)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });



            modelBuilder.Entity<ColorCodes>(entity =>
           {
               entity.Property(e => e.FontColor).HasMaxLength(200);

               entity.Property(e => e.HexCode).HasMaxLength(50);
           });

            modelBuilder.Entity<ErrorLog>(entity =>
            {
                entity.Property(e => e.Date).HasColumnType("datetime");
            });

            modelBuilder.Entity<LoginInfo>(entity =>
            {
                entity.Property(e => e.Blocked).HasDefaultValueSql("((0))");

                entity.Property(e => e.IncorrectAttempt).HasDefaultValueSql("((0))");

                entity.Property(e => e.LastLogInTime).HasColumnType("datetime");

                entity.Property(e => e.Password)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.LoginInfo)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_LoginInfo_User");
            });

            modelBuilder.Entity<MachineLog>(entity =>
            {
                entity.Property(e => e.BatchNumber)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Data)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.DowntimeReason)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Shift)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.TimeStamp).HasColumnType("datetime");

                entity.Property(e => e.Topic)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<MachineMaster>(entity =>
            {
                entity.Property(e => e.Category)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Code)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Name)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.OEM)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.OEMNumber)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Type)
                    .HasMaxLength(10)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<MachineOnOff>(entity =>
            {
                entity.Property(e => e.BatchNumber)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Data)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.DowntimeReason)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.TimeStamp).HasColumnType("datetime");

                entity.Property(e => e.Topic)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<ProductMaster>(entity =>
            {
                entity.Property(e => e.Code)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Description)
                    .HasMaxLength(500)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.IsDeleted).HasDefaultValueSql("((0))");

                entity.Property(e => e.IsDisabled).HasDefaultValueSql("((0))");

                entity.Property(e => e.LastName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserName)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
