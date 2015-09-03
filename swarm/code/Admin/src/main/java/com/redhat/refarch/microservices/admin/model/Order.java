package com.redhat.refarch.microservices.admin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * @author Bruno Georges
 */

@Entity
@Table(name = "ORDER_TRANSACTION")
@NamedQueries({
        @NamedQuery(name = "Order.findAll", query = "SELECT o FROM Order o")
})

@XmlRootElement
public class Order implements Serializable
{
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Column(name = "tx_number")
	private long transactionNumber;

	@Column(name = "tx_date")
	private Date transactionDate;

	public long getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}


	public long getTransactionNumber()
	{
		return transactionNumber;
	}

	public void setTransactionNumber(long transactionNumber)
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


  @Override
  public boolean equals(Object obj)
  {
    if (null == obj)
      return false;
    if (!(obj instanceof Order))
      return false;

    Order that = (Order) obj;
    if (that.id == this.id)
      return true;
    else
      return false;
  }

	@Override
  public int hashCode()
  {
        return Objects.hash(this.id, this.transactionNumber);
  }

}
