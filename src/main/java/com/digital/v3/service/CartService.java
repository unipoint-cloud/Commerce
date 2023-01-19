package com.digital.v3.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.digital.v3.dao.CartDao;
import com.digital.v3.schema.Cart;
import com.digital.v3.schema.CartProduct;
import com.digital.v3.sql.vo.PartyProductVO;

@Component
public class CartService {
	
	@Resource
	InventoryService inventorySvc;
	@Autowired
	CartDao cartDao;

	/* 장바구니에 상품 등록 */
	public boolean cartProductWrite (long personId, CartProduct cartProduct) throws Exception {
		try {
			PartyProductVO cartProductVo = setCartProductVO(personId, cartProduct);

			// 입력 수량 유효성 확인 - 중복 상품의 담은 수량을 입력 수량에 더한 값으로 계산
			int cartQuantity = cartDao.getQuantityOfPluralCartProduct(cartProductVo);
			cartQuantity += cartProductVo.getQuantity();
			if (!inventorySvc.inventoryQuantityCheck(cartProduct.getProductId(), cartQuantity)) {
				throw new Exception("상품 ID: " + cartProduct.getProductId() + "의 입력 수량이 재고 수량을 초과합니다.");
			}
	
			// 유효한 입력 수량이면 write
			cartDao.createCartProduct(cartProductVo);
			return true;
		} catch (Exception e) {
			throw e;
		}
	}

	/* 장바구니 검색 - personId */
	public Cart cartSearch (long personId) throws Exception {

		List<PartyProductVO> cartProductVOList = cartDao.getCartProductByPerson(personId);

		Cart cart = new Cart();
		List<CartProduct> cartProductList = new ArrayList<CartProduct>();
		for (PartyProductVO cartProductVo : cartProductVOList) {
			CartProduct cartProduct = setCartProduct(cartProductVo);
			cartProductList.add(cartProduct);
		}
		cart.setCart(cartProductList);
		
		return cart;
	}
	
	/* 장바구니 상품 삭제 */
	public boolean cartProductDelete (long personId, CartProduct cartProduct) throws Exception {
		try {
			PartyProductVO partyProductVo = setCartProductVO(personId, cartProduct);
			
			// cartProduct 존재 여부 확인
			if (cartDao.isExistCartProduct(partyProductVo) == 0) {
				throw new Exception("장바구니에 해당하는 상품이 없습니다."); 
			}
			
			// 존재하면 delete
			cartDao.deleteCartProduct(partyProductVo);
			return true;
		} catch (Exception e) {
			throw e;
		}
	}
	
	public CartProduct setCartProduct (PartyProductVO cartProductVo) {
		CartProduct cartProduct = new CartProduct();
		
		cartProduct.setProductId(cartProductVo.getProductId());
		cartProduct.setQuantity(cartProductVo.getQuantity());
		
		return cartProduct;
	}
	
	public PartyProductVO setCartProductVO (long personId, CartProduct cartProduct) {
		PartyProductVO cartProductVo = new PartyProductVO();
		
		cartProductVo.setPersonId(personId);
		cartProductVo.setProductId(cartProduct.getProductId());
		cartProductVo.setQuantity(cartProduct.getQuantity());
		
		return cartProductVo;
	}
	
}
