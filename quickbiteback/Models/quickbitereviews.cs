using System;
using System.Collections.Generic;

namespace quickbiteback.Models;

public partial class quickbitereviews
{
    public int Id { get; set; }

    public string Username { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string Text { get; set; } = null!;

    public sbyte Stars { get; set; }

    public DateTime CreatedAt { get; set; }
}
