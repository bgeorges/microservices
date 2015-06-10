package com.redhat.refarch.microservices.presentation;


public class OrderItem
{

	private long id;
	private long sku;
	private int quantity;
	private String name;
	private String description;
	private Integer length;
	private Integer width;
	private Integer height;
	private Integer weight;
	private Boolean featured;
	private Integer availability;
	private Double price;
	private String image;

	public long getId()
	{
		return id;
	}

	public void setId(long id)
	{
		this.id = id;
	}

	public long getSku()
	{
		return sku;
	}

	public void setSku(long sku)
	{
		this.sku = sku;
	}

	public int getQuantity()
	{
		return quantity;
	}

	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public Integer getLength()
	{
		return length;
	}

	public void setLength(Integer length)
	{
		this.length = length;
	}

	public Integer getWidth()
	{
		return width;
	}

	public void setWidth(Integer width)
	{
		this.width = width;
	}

	public Integer getHeight()
	{
		return height;
	}

	public void setHeight(Integer height)
	{
		this.height = height;
	}

	public Integer getWeight()
	{
		return weight;
	}

	public void setWeight(Integer weight)
	{
		this.weight = weight;
	}

	public Boolean getFeatured()
	{
		return featured;
	}

	public void setFeatured(Boolean featured)
	{
		this.featured = featured;
	}

	public Integer getAvailability()
	{
		return availability;
	}

	public void setAvailability(Integer availability)
	{
		this.availability = availability;
	}

	public Double getPrice()
	{
		return price;
	}

	public void setPrice(Double price)
	{
		this.price = price;
	}

	public String getImage()
	{
		return image;
	}

	public void setImage(String image)
	{
		this.image = image;
	}

	@Override
	public String toString()
	{
		return "OrderItem [id=" + id + ", sku=" + sku + ", quantity=" + quantity + ", name=" + name + ", description=" + description + ", length="
				+ length + ", width=" + width + ", height=" + height + ", weight=" + weight + ", featured=" + featured + ", availability="
				+ availability + ", price=" + price + ", image=" + image + "]";
	}
}