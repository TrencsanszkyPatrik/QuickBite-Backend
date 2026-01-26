using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models
{
    public partial class QuickBiteDbContext : DbContext
    {
        public QuickBiteDbContext()
        {
        }

        public QuickBiteDbContext(DbContextOptions<QuickBiteDbContext> options)
            : base(options)
        {
        }

        // === ALL TABLES GO HERE ===
        public virtual DbSet<quickbitereviews> quickbitereviews { get; set; }
        public virtual DbSet<categories> categories { get; set; }
        public virtual DbSet<restaurants> restaurants { get; set; }
        public virtual DbSet<reviews> reviews { get; set; }
        public virtual DbSet<users> users { get; set; }
        public virtual DbSet<user_addresses> user_addresses { get; set; }
        public virtual DbSet<user_payment_methods> user_payment_methods { get; set; }
        public virtual DbSet<menu_items> menu_items { get; set; }

        // === CONNECTION STRING ===
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code.
            => optionsBuilder.UseMySQL("Server=localhost;Port=3306;Database=quickbite;Uid=root;Pwd=;");

        // === MODEL BUILDING ===
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // ---- quickbite_reviews ----
            modelBuilder.Entity<quickbitereviews>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("PRIMARY");

                entity.ToTable("quickbite_reviews");

                entity.Property(e => e.Id)
                    .HasColumnType("int(11)")
                    .HasColumnName("id");

                entity.Property(e => e.CreatedAt)
                    .HasDefaultValueSql("'current_timestamp()'")
                    .HasColumnType("datetime")
                    .HasColumnName("created_at");

                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .HasColumnName("name");

                entity.Property(e => e.Stars)
                    .HasColumnType("tinyint(4)")
                    .HasColumnName("stars");

                entity.Property(e => e.Text)
                    .HasColumnType("text")
                    .HasColumnName("text");

                entity.Property(e => e.Username)
                    .HasMaxLength(50)
                    .HasColumnName("username");
            });

            // ---- categories ----
            modelBuilder.Entity<categories>(entity =>
            {
                entity.HasKey(e => e.id).HasName("PRIMARY");
            });

            // ---- restaurants ----
            modelBuilder.Entity<restaurants>(entity =>
            {
                entity.HasKey(e => e.id).HasName("PRIMARY");

                entity.Property(e => e.created_at)
                      .HasDefaultValueSql("'current_timestamp()'");

                entity.HasOne(d => d.cuisine)
                    .WithMany(p => p.restaurants)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_restaurants_category");
            });

            // ---- reviews ----
            modelBuilder.Entity<reviews>(entity =>
            {
                entity.HasKey(e => e.id).HasName("PRIMARY");

                entity.Property(e => e.comment)
                      .HasDefaultValueSql("'NULL'");

                entity.Property(e => e.created_at)
                      .HasDefaultValueSql("'current_timestamp()'");

                entity.HasOne(d => d.restaurant)
                    .WithMany(p => p.reviews)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_reviews_restaurant");

                entity.HasOne(d => d.user)
                    .WithMany(p => p.reviews)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_reviews_user");
            });

            // ---- users ----
            modelBuilder.Entity<users>(entity =>
            {
                entity.HasKey(e => e.id).HasName("PRIMARY");

                entity.Property(e => e.created_at)
                      .HasDefaultValueSql("'current_timestamp()'");
            });

            // ---- user_addresses ----
            modelBuilder.Entity<user_addresses>(entity =>
            {
                entity.HasKey(e => e.id).HasName("PRIMARY");
                entity.HasOne(d => d.user)
                    .WithMany(p => p.user_addresses)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_user_addresses_user");
            });

            // ---- user_payment_methods ----
            modelBuilder.Entity<user_payment_methods>(entity =>
            {
                entity.HasKey(e => e.id).HasName("PRIMARY");
                entity.HasOne(d => d.user)
                    .WithMany(p => p.user_payment_methods)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_user_payment_methods_user");
            });

            // ---- menu_items ----
            modelBuilder.Entity<menu_items>(entity =>
            {
                entity.HasKey(e => e.id).HasName("PRIMARY");

                entity.ToTable("menu_items");

                entity.Property(e => e.created_at)
                      .HasDefaultValueSql("'current_timestamp()'");

                entity.HasOne(d => d.restaurant)
                    .WithMany(p => p.menu_items)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_menu_items_restaurant");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
