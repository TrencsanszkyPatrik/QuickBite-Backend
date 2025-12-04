using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

public partial class QuickBiteDbContext : DbContext
{
    public QuickBiteDbContext()
    {
    }

    public QuickBiteDbContext(DbContextOptions<QuickBiteDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<categories> categories { get; set; }

    public virtual DbSet<restaurants> restaurants { get; set; }

    public virtual DbSet<reviews> reviews { get; set; }

    public virtual DbSet<users> users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseMySQL("Server=localhost;Port=3306;Database=quickbite;Uid=root;Pwd=;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<categories>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PRIMARY");
        });

        modelBuilder.Entity<restaurants>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PRIMARY");

            entity.Property(e => e.created_at).HasDefaultValueSql("'current_timestamp()'");

            entity.HasOne(d => d.cuisine).WithMany(p => p.restaurants)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("fk_restaurants_category");
        });

        modelBuilder.Entity<reviews>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PRIMARY");

            entity.Property(e => e.comment).HasDefaultValueSql("'NULL'");
            entity.Property(e => e.created_at).HasDefaultValueSql("'current_timestamp()'");

            entity.HasOne(d => d.restaurant).WithMany(p => p.reviews)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("fk_reviews_restaurant");

            entity.HasOne(d => d.user).WithMany(p => p.reviews)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("fk_reviews_user");
        });

        modelBuilder.Entity<users>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PRIMARY");

            entity.Property(e => e.created_at).HasDefaultValueSql("'current_timestamp()'");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
