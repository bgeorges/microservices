package com.redhat.refarch.microservices.presentation;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order
{

	private long id;
	private String status;
	private Long transactionNumber;
	private Date transactionDate;
	private List<OrderItem> orderItems = new ArrayList<OrderItem>();

	public long getId()
	{
		return id;
	}

	public void setId(long id)
	{
		this.id = id;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public Long getTransactionNumber()
	{
		return transactionNumber;
	}

	public void setTransactionNumber(Long transactionNumber)
	{
		this.transactionNumber = transactionNumber;
	}

	public Date getTransactionDate()
	{
		return transactionDate;
	}

	public void setTransactionDate(Date transactionDate)
	{
		this.transactionDate = transactionDate;
	}

	public List<OrderItem> getOrderItems()
	{
		return orderItems;
	}

	public void addOrderItem(OrderItem orderItem)
	{
		this.orderItems.add( orderItem );
	}
}