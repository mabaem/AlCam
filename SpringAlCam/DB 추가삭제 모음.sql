/*

	select * from goods
	select * from membertb
	select * from bookmark_goods
	select * from bmk_goods_view;

	ALTER TABLE bookmark_goods DROP CONSTRAINT pk_bookmark_goods_idx;
	ALTER TABLE bookmark_goods DROP CONSTRAINT fk_bookmark_goods_m_idx;
	ALTER TABLE bookmark_goods DROP CONSTRAINT fk_bookmark_goods_g_idx;

	drop table    bookmark_goods;
	drop table    goods;
	drop table    membertb;
	drop table    notice;
	drop table    commenttb;
	drop table    bookmark_place;
	drop table    recommend_place;
	drop table    place;
	
	drop view     bmk_goods_view;
	drop view     bmk_place_view;
	
	drop sequence seq_bookmark_bmk_goods_g_idx;
	drop sequence seq_notice_n_idx;
	drop sequence seq_commenttb_c_idx;
	drop sequence seq_bookmark_bmk_place_p_idx;
	drop sequence seq_recommend_place_idx;
	drop sequence seq_place_p_idx;
	drop sequence seq_membertb_m_idx;




select * from place

commit
*/