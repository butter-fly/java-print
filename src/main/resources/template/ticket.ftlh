<!DOCTYPE html>
<html>
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<head>
		<style>
		body {
			font-family: '微软雅黑';
			margin:0;
			padding:0;
		}
		.order-print {
		    width: 8cm;
		    /*margin: auto;*/
		    /*border: 1px solid #000;*/
		    border-top: 1px solid #000;
		}
		.order-print .header{
		    border-bottom: 1px solid #000;
		    padding: 0.25cm;
		}
		.order-print .header h2{
		    text-align: center;
		}
		.order-print .product-list{
		    border-bottom: 1px solid #000;
		    padding: 0.25cm;
		}
		.order-print .product-list .product{
		    display: flex;
		    margin: 0.25cm;
		}
		.order-print .product-list .product .left{
		    width:72%;
		    border: 1px solid #000;
		    border-radius: 3px;
		    padding: 5px;
			float: left;
		}
		.order-print .product-list .product .left .cuptype{
		    border-bottom: 1px solid #000;
		}
		.order-print .product-list .product .right{
		    width:20%;
		    padding: 5px;
			float: left;
		}
		.order-print .footer{
		    display: flex;
		    padding: 0.25cm;
		}
		.order-print .footer .qrcode{
		    text-align:left;
		}
		.order-print .footer .price{
		    width: 50%;
		    text-align: right;
		    float:right;
		}
		</style>
	</head>
	<body>
		<#assign seq=[1,2]/>
		<#list seq as s>
			<div class="order-print" id="orderPrint" style="width: 8cm; page-break-before:always;page-break-after:always">
			    <div class="header" style="border-bottom: 1px solid #000; padding: 0.25cm;">
			      <h2 style="text-align: center;">COFFEE PENNY<span><#if s==2>(副本)</#if></span></h2>
			      <div>
			      	<span>订单号：</span>
			      	<#if order.orderDto?? && order.orderDto.orderNo??>
			      		<span>${order.orderDto.orderNo}</span>
			      	</#if>
			      </div>
				  <div>
			      	<span>会员卡号：</span>
			      	<#if order.orderDto?? && order.orderDto.cardNo??>
			      		<span>${order.orderDto.cardNo}</span>
			      	</#if>
			      </div>
			      <div>
			      	<span>联系人：</span>
		      		<#if order.orderAddressDto?? && order.orderAddressDto.consigneeName??>
		      			<span>${order.orderAddressDto.consigneeName}</span>
		      		</#if>
			      </div>
			      <div>
			      	<span>电话：</span>
			      	<#if order.orderAddressDto?? && order.orderAddressDto.consigneePhone??>
			      		<span>${order.orderAddressDto.consigneePhone}</span>
			      	</#if>
		      	  </div>
			      <div>
			      	<span>目的地：</span>
			      	<#if order.orderAddressDto?? && order.orderAddressDto.address??>
			      		<span>${order.orderAddressDto.address}</span>
			      	</#if>
			      </div>
			      <div>
			      	<span>支付方式：</span>
			      	<#if order.orderDto?? && order.orderDto.payType??>
			      		<span>
			      			<#if order.orderDto.payType==1>微信支付</#if>
			          		<#if order.orderDto.payType==2>现金支付</#if>
			          		<#if order.orderDto.payType==3>支付宝支付</#if>
			      		</span>
			      	</#if>
			      </div>
			      <div>
			      	<span>备注：</span>
			      	<#if order.orderDto?? && order.orderDto.remark??>
			      		<span>${order.orderDto.remark}</span>
			      	</#if>
			      </div>
			    </div>
			    <div>
				  <div class="product-list" style="border-bottom: 1px solid #000;padding: 0.25cm;">
					  <#list order.orderProductDtos as orderProduct>
					      <div class="product" style="display: flex; margin: 0.25cm;">
					        <div class="left" style="width:72%; border: 1px solid #000;border-radius: 3px; padding: 5px;">
					          <div class="name">${orderProduct.productChname}(${orderProduct.productEnname})</div>
					          <div class="cuptype" style="border-bottom: 1px solid #000;">
					          	<#if orderProduct.productCup?? && orderProduct.productCup==1>小杯</#if>
				          		<#if orderProduct.productCup?? && orderProduct.productCup==2>标准杯</#if>
				          		<#if orderProduct.productCup?? && orderProduct.productCup==3>升级杯</#if>
					          </div>
					          <div class="attachements">
					          	<#list orderProduct.attachmentDtos as attachment>
					            	<span>
					            		<#if attachment.name?? && attachment.price??>
					            			${attachment.name} * ￥${attachment.price} * ${attachment.amount}
					            		</#if>
					            	</span>
					            </#list>
					            <span>${orderProduct.remark}</span>
					           </div>
					        </div>
					        <div class="right" style="width:20%;padding: 5px;">
					          <div class="amount">X <#if orderProduct.amount??>${orderProduct.amount}</#if></div>
					          <div class="price">￥ <#if orderProduct.price??>${orderProduct.price}</#if></div>
					        </div>
					      </div>
					      <div style="clear:both"></div>
					</#list>
			    </div>
			    <div class="footer" style="display: flex; padding: 0.25cm;">
			      <div class="qrcode" style="text-align:left;float:left">
			        <#if qrcode??><img src="${qrcode}"></img></#if>
			      </div>
			      <div class="price" style="width: 50%; text-align: left;float:right">
			        <div>
			        	<span>总金额：</span>
			        	<#if order.orderDto?? && order.orderDto.totalPrice??>
			        		<span>￥ ${order.orderDto.totalPrice}</span>
			        	</#if>
		        	</div>
			        <div>
			        	<span>优惠：</span>
			        	<#--<#if order.orderDto?? && order.orderDto.offer??>
			        		<span>￥ ${order.orderDto.offer}</span>
			        	</#if>-->
			        </div>
			        <div>
			        	<#if order.orderOfferDtos??>
				        	<#list order.orderOfferDtos as offer>
				        		<#if offer?? && offer.type == 1><span>买一送一 * ${offer.amount}</span></#if>
				        		<#if offer?? && offer.type == 2><span>免费升杯 * ${offer.amount}</span></#if>
				        		<#if offer?? && offer.type == 3><span>免费饮料 * ${offer.amount}</span></#if>
				        	</#list>
			        	</#if>
			        </div>
			        <div>
			        	<span>支付：</span>
			        	<#if order.orderDto?? && order.orderDto.userPay??>
			        		<span>￥ ${order.orderDto.userPay}</span>
			        	</#if>
			        </div>
			      </div>
			      <div style="clear:both"></div>
			    </div>
			  </div>
		  </#list>
	  </body>
  </html>