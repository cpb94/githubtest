$PBExportHeader$w_menuses.srw
forward
global type w_menuses from window
end type
type uo_destino from u_em_campo_2 within w_menuses
end type
type cb_3 from commandbutton within w_menuses
end type
type dw_2 from datawindow within w_menuses
end type
type cb_2 from commandbutton within w_menuses
end type
type cbx_5 from checkbox within w_menuses
end type
type cbx_4 from checkbox within w_menuses
end type
type cbx_3 from checkbox within w_menuses
end type
type cbx_2 from checkbox within w_menuses
end type
type cbx_1 from checkbox within w_menuses
end type
type dw_1 from datawindow within w_menuses
end type
type cb_1 from commandbutton within w_menuses
end type
type gb_2 from groupbox within w_menuses
end type
type gb_1 from groupbox within w_menuses
end type
end forward

global type w_menuses from window
integer x = 654
integer y = 268
integer width = 4119
integer height = 3228
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 79741120
uo_destino uo_destino
cb_3 cb_3
dw_2 dw_2
cb_2 cb_2
cbx_5 cbx_5
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
dw_1 dw_1
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
end type
global w_menuses w_menuses

type variables
boolean n1, n2, n3, n4, n5

end variables

forward prototypes
public function string f_quitar_caracteres_raros (string cadena)
end prototypes

public function string f_quitar_caracteres_raros (string cadena);long donde

donde = pos(cadena, "&")

if donde > 0 then
	cadena = replace(cadena, donde, 1, "")	
end if

donde = pos(cadena, "Shift+")

if donde > 0 then
	cadena = replace(cadena, donde, 6, "")	
end if

donde = pos(cadena, "Ctrl+")

if donde > 0 then
	cadena = replace(cadena, donde, 5, "")	
end if

donde = pos(cadena, "F1")

if donde > 0 then
	cadena = replace(cadena, donde, 2, "")	
end if

return cadena


end function

on w_menuses.create
this.uo_destino=create uo_destino
this.cb_3=create cb_3
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.uo_destino,&
this.cb_3,&
this.dw_2,&
this.cb_2,&
this.cbx_5,&
this.cbx_4,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.dw_1,&
this.cb_1,&
this.gb_2,&
this.gb_1}
end on

on w_menuses.destroy
destroy(this.uo_destino)
destroy(this.cb_3)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_1.sharedata(dw_2)

n1 = false
n2 = false
n3 = false
n4 = false
n5 = false


end event

type uo_destino from u_em_campo_2 within w_menuses
event destroy ( )
integer x = 1600
integer y = 2996
integer width = 416
integer height = 72
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_destino.destroy
call u_em_campo_2::destroy
end on

event modificado;String des

des = f_nombre_usuario(uo_destino.em_codigo.text)

IF Trim(des) <> "" Then uo_destino.em_campo.text= des

IF Trim(uo_destino.em_campo.text)="" THEN 
 IF Trim(uo_destino.em_codigo.text)<>"" Then uo_destino.em_campo.SetFocus()
 uo_destino.em_campo.text=""
 uo_destino.em_codigo.text=""
 Return
END IF

if f_nombre_usuario(uo_destino.em_codigo.text)="" then
 f_mensaje("!Atención","El usuario no existe")
 uo_destino.em_campo.text=""
 uo_destino.em_codigo.text=""
 Return	
End if	
end event

event getfocus;call super::getfocus;valor_empresa = FALSE
ue_titulo     = "Ayuda seleccion de usuarios"
ue_datawindow = "dw_ayuda_usuarios"
ue_filtro     = ""
end event

type cb_3 from commandbutton within w_menuses
integer x = 2043
integer y = 2972
integer width = 256
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;dw_1.update()
commit;

messagebox("EXITO", "Menu Grabado")
end event

type dw_2 from datawindow within w_menuses
boolean visible = false
integer x = 1902
integer y = 396
integer width = 416
integer height = 96
integer taborder = 30
string dataobject = "dw_menuses2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_menuses
integer x = 2304
integer y = 2972
integer width = 288
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;f_imprimir_datawindow(dw_2)
end event

type cbx_5 from checkbox within w_menuses
integer x = 1262
integer y = 2996
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
boolean checked = true
boolean lefttext = true
end type

event clicked;if not this.checked then
	dw_1.modify(" datawindow.header.2.height = 40 ")
	dw_1.modify(" datawindow.header.3.height = 40 ")
	dw_1.modify(" datawindow.header.4.height = 40 ")
	dw_1.modify(" datawindow.header.5.height = 40 ")
	dw_1.setfilter("")
	dw_1.filter()	
	dw_1.sort()
	cbx_1.checked = true
	cbx_2.checked = true
	cbx_3.checked = true
	cbx_4.checked = true
end if
end event

type cbx_4 from checkbox within w_menuses
integer x = 946
integer y = 2996
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel 5"
boolean checked = true
boolean lefttext = true
end type

event clicked;if this.checked then
	dw_1.modify(" datawindow.header.5.height = 40 ")
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.setfilter(" not isnull(nivel5_nombre) ")
	dw_1.filter()
	dw_1.sort()
else
	dw_1.modify(" datawindow.header.5.height = 0 ")
	dw_1.setfilter("")
	dw_1.filter()	
	dw_1.sort()
end if
cbx_5.checked = false
end event

type cbx_3 from checkbox within w_menuses
integer x = 635
integer y = 2988
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel 4"
boolean checked = true
boolean lefttext = true
end type

event clicked;if this.checked then
	dw_1.modify(" datawindow.header.4.height = 40 ")
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.setfilter(" not isnull(nivel4_nombre) ")
	dw_1.filter()
	dw_1.sort()	
else
	dw_1.modify(" datawindow.header.4.height = 0 ")
	dw_1.setfilter("")
	dw_1.filter()	
	dw_1.sort()
end if
cbx_5.checked = false
end event

type cbx_2 from checkbox within w_menuses
integer x = 325
integer y = 2988
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel 3"
boolean checked = true
boolean lefttext = true
end type

event clicked;if this.checked then
	dw_1.modify(" datawindow.header.3.height = 40 ")
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.setfilter(" not isnull(nivel3_nombre) ")
	dw_1.filter()
	dw_1.sort()	
else
	dw_1.modify(" datawindow.header.3.height = 0 ")
	dw_1.setfilter("")
	dw_1.filter()	
	dw_1.sort()
end if
cbx_5.checked = false
end event

type cbx_1 from checkbox within w_menuses
integer x = 27
integer y = 2992
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel 2"
boolean checked = true
boolean lefttext = true
end type

event clicked;if this.checked then
	dw_1.modify(" datawindow.header.2.height = 40 ")
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.setfilter(" not isnull(nivel2_nombre) ")
	dw_1.filter()
	dw_1.sort()	
else
	dw_1.modify(" datawindow.header.2.height = 0 ")
	dw_1.setfilter("")
	dw_1.filter()	
	dw_1.sort()
end if
cbx_5.checked = false
end event

type dw_1 from datawindow within w_menuses
integer x = 23
integer y = 16
integer width = 4014
integer height = 2920
integer taborder = 40
string dataobject = "dw_menuses2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long cont, total
string texto, texto2

total = this.rowcount()

choose case dwo.name
	case "n1"
		if n1 then
			for cont = 1 to total
				this.object.nivel1_visible[cont] = 'N'
			next
		else
			for cont = 1 to total
				this.object.nivel1_visible[cont] = 'S'
			next
		end if
		n1 = not n1
	case "n2"
		if n2 then
			for cont = 1 to total
				this.object.nivel2_visible[cont] = 'N'
			next
		else
			for cont = 1 to total
				this.object.nivel2_visible[cont] = 'S'
			next
		end if
		n2 = not n2
	case "n3"
		if n3 then
			for cont = 1 to total
				this.object.nivel3_visible[cont] = 'N'
			next
		else
			for cont = 1 to total
				this.object.nivel3_visible[cont] = 'S'
			next
		end if
		n3 = not n3
	case "n4"
		if n4 then
			for cont = 1 to total
				this.object.nivel4_visible[cont] = 'N'
			next
		else
			for cont = 1 to total
				this.object.nivel4_visible[cont] = 'S'
			next
		end if
		n4 = not n4
	case "n5"
		if n5 then
			for cont = 1 to total
				this.object.nivel5_visible[cont] = 'N'
			next
		else
			for cont = 1 to total
				this.object.nivel5_visible[cont] = 'S'
			next
		end if
		n5 = not n5
	case "nivel1_visible"
		if this.object.nivel1_visible[row] = 'S' then
			texto = this.object.nivel1_nombre[row]
			for cont = 1 to total
				if this.object.nivel1_nombre[cont] = texto then
					this.object.nivel1_visible[cont] = 'N'
				end if
			next
		else
			texto = this.object.nivel1_nombre[row]
			for cont = 1 to total
				if this.object.nivel1_nombre[cont] = texto then
					this.object.nivel1_visible[cont] = 'S'
				end if
			next			
		end if
	case "nivel2_visible"
		if this.object.nivel2_visible[row] = 'S' then
			texto = this.object.nivel2_nombre[row]
			for cont = 1 to total
				if this.object.nivel2_nombre[cont] = texto then
					this.object.nivel2_visible[cont] = 'N'
				end if
			next
		else
			texto = this.object.nivel2_nombre[row]
			for cont = 1 to total
				if this.object.nivel2_nombre[cont] = texto then
					this.object.nivel2_visible[cont] = 'S'
				end if
			next			
		end if		
	case "nivel3_visible"
		if this.object.nivel3_visible[row] = 'S' then
			texto  = this.object.nivel3_nombre[row]
			texto2 = this.object.nivel2_nombre[row]
			for cont = 1 to total
				if this.object.nivel3_nombre[cont] = texto then
					if this.object.nivel2_nombre[cont] = texto2 then
						this.object.nivel3_visible[cont] = 'N'
					end if
				end if
			next
		else
			texto  = this.object.nivel3_nombre[row]
			texto2 = this.object.nivel2_nombre[row]
			for cont = 1 to total
				if this.object.nivel3_nombre[cont] = texto then
					if this.object.nivel2_nombre[cont] = texto2 then
						this.object.nivel3_visible[cont] = 'S'
					end if
				end if
			next			
		end if		
	case "nivel4_visible"
		if this.object.nivel4_visible[row] = 'S' then
			texto  = this.object.nivel4_nombre[row]
			texto2 = this.object.nivel3_nombre[row]
			for cont = 1 to total
				if this.object.nivel4_nombre[cont] = texto then
					if this.object.nivel3_nombre[cont] = texto2 then
						this.object.nivel4_visible[cont] = 'N'
					end if
				end if
			next
		else
			texto  = this.object.nivel4_nombre[row]
			texto2 = this.object.nivel3_nombre[row]
			for cont = 1 to total
				if this.object.nivel4_nombre[cont] = texto then
					if this.object.nivel3_nombre[cont] = texto2 then
						this.object.nivel4_visible[cont] = 'S'
					end if
				end if
			next			
		end if		
	case "nivel5_visible"
		if this.object.nivel5_visible[row] = 'S' then
			texto  = this.object.nivel5_nombre[row]
			texto2 = this.object.nivel4_nombre[row]
			for cont = 1 to total
				if this.object.nivel5_nombre[cont] = texto then
					if this.object.nivel4_nombre[cont] = texto2 then
						this.object.nivel5_visible[cont] = 'N'
					end if
				end if
			next
		else
			texto  = this.object.nivel5_nombre[row]
			texto2 = this.object.nivel4_nombre[row]
			for cont = 1 to total
				if this.object.nivel5_nombre[cont] = texto then
					if this.object.nivel4_nombre[cont] = texto2 then
						this.object.nivel5_visible[cont] = 'S'
					end if
				end if
			next			
		end if		
end choose
end event

type cb_1 from commandbutton within w_menuses
integer x = 3333
integer y = 2972
integer width = 695
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar Menu"
end type

event clicked;long   cont1, cont2, cont3, cont4, cont5, existe, linea = 0
string texto, nombre_menu, usuario, &
		 m1_nombre, m2_nombre, m3_nombre, m4_nombre, m5_nombre, m6_nombre, &
		 m1_visible, m2_visible, m3_visible, m4_visible, m5_visible, m6_visible
menu   mi_menu

usuario     = uo_destino.em_codigo.text
mi_menu 		= parentwindow().menuid
nombre_menu = parentwindow().menuname

select count(*)
into   :existe
from   menus
where  usuario 	 = :usuario 
and 	 nombre_menu = :nombre_menu;

if isnull(existe) then existe = 0

if existe > 0 then
	dw_1.retrieve(nombre_menu, usuario)
else

	for cont1 = 1 to upperbound(mi_menu.item[])
		f_mensaje_proceso("WooOOOOoOOOoo!!!", cont1, upperbound(mi_menu.item[]))
		
		m1_nombre = mi_menu.item[cont1].text	
		if m1_nombre = "-" then continue
		m1_nombre = f_quitar_caracteres_raros(m1_nombre)
		if mi_menu.item[cont1].visible then
			m1_visible = 'S'
		else
			m1_visible = 'N'
		end if
								
		if upperbound(mi_menu.item[cont1].item[]) > 0 then
			for cont2 = 1 to upperbound(mi_menu.item[cont1].item[])
				m2_nombre = mi_menu.item[cont1].item[cont2].text	
	//			if m2_nombre = "-" then continue
				m2_nombre = f_quitar_caracteres_raros(m2_nombre)
				if mi_menu.item[cont1].item[cont2].visible then 
					m2_visible = 'S'
				else
					m2_visible = 'N'
				end if
					
				if upperbound(mi_menu.item[cont1].item[cont2].item[]) > 0 then
					for cont3 = 1 to upperbound(mi_menu.item[cont1].item[cont2].item[])
						m3_nombre = mi_menu.item[cont1].item[cont2].item[cont3].text	
	//					if m3_nombre = "-" then continue
						m3_nombre = f_quitar_caracteres_raros(m3_nombre)
						if mi_menu.item[cont1].item[cont2].item[cont3].visible then
							m3_visible = 'S'
						else
							m3_visible = 'N'
						end if
						
						if upperbound(mi_menu.item[cont1].item[cont2].item[cont3].item[]) > 0 then
							for cont4 = 1 to upperbound(mi_menu.item[cont1].item[cont2].item[cont3].item[])
								m4_nombre = mi_menu.item[cont1].item[cont2].item[cont3].item[cont4].text	
	//							if m4_nombre = "-" then continue
								m4_nombre = f_quitar_caracteres_raros(m4_nombre)
								if mi_menu.item[cont1].item[cont2].item[cont3].item[cont4].visible then
									m4_visible = 'S'
								else
									m4_visible = 'N'
								end if
								
								if upperbound(mi_menu.item[cont1].item[cont2].item[cont3].item[cont4].item[]) > 0 then
									for cont5 = 1 to upperbound(mi_menu.item[cont1].item[cont2].item[cont3].item[cont4].item[])
										m5_nombre = mi_menu.item[cont1].item[cont2].item[cont3].item[cont4].item[cont5].text	
	//									if m5_nombre = "-" then continue
										m5_nombre = f_quitar_caracteres_raros(m5_nombre)
										if mi_menu.item[cont1].item[cont2].item[cont3].item[cont4].item[cont5].visible then
											m5_visible = 'S'
										else
											m5_visible = 'N'
										end if
										
										linea ++
										
										insert into menus  
											(usuario,   
											nombre_menu,   
											linea,   
											nivel1_id,   
											nivel1_nombre,   
											nivel1_visible,   
											nivel2_id,   
											nivel2_nombre,   
											nivel2_visible,   
											nivel3_id,   
											nivel3_nombre,   
											nivel3_visible,   
											nivel4_id,   
											nivel4_nombre,   
											nivel4_visible,   
											nivel5_id,   
											nivel5_nombre,   
											nivel5_visible,   
											nivel6_id,   
											nivel6_nombre,   
											nivel6_visible)
										values 
											(:usuario,   
											:nombre_menu,   
											:linea,   
											:cont1,   
											:m1_nombre,   
											:m1_visible,   
											:cont2,   
											:m2_nombre,   
											:m2_visible,   
											:cont3,   
											:m3_nombre,   
											:m3_visible,   
											:cont4,   
											:m4_nombre,   
											:m4_visible,   
											:cont5,   
											:m5_nombre,   
											:m5_visible,   
											null,
											null,
											null);
										
										if sqlca.sqlcode = 0 then
											commit;
										else
											rollback;
										end if
										
									next
								else
									
									linea ++
									
									insert into menus  
										(usuario,   
										nombre_menu,   
										linea,   
										nivel1_id,   
										nivel1_nombre,   
										nivel1_visible,   
										nivel2_id,   
										nivel2_nombre,   
										nivel2_visible,   
										nivel3_id,   
										nivel3_nombre,   
										nivel3_visible,   
										nivel4_id,   
										nivel4_nombre,   
										nivel4_visible,   
										nivel5_id,   
										nivel5_nombre,   
										nivel5_visible,   
										nivel6_id,   
										nivel6_nombre,   
										nivel6_visible)
									values 
										(:usuario,   
										:nombre_menu,   
										:linea,   
										:cont1,   
										:m1_nombre,   
										:m1_visible,   
										:cont2,   
										:m2_nombre,   
										:m2_visible,   
										:cont3,   
										:m3_nombre,   
										:m3_visible,   
										:cont4,   
										:m4_nombre,   
										:m4_visible,   
										null,
										null,
										null,
										null,
										null,
										null);
									
									if sqlca.sqlcode = 0 then
										commit;
									else
										rollback;
									end if
									
								end if
							next	
						else
							
							linea ++
							
							insert into menus  
								(usuario,   
								nombre_menu,   
								linea,   
								nivel1_id,   
								nivel1_nombre,   
								nivel1_visible,   
								nivel2_id,   
								nivel2_nombre,   
								nivel2_visible,   
								nivel3_id,   
								nivel3_nombre,   
								nivel3_visible,   
								nivel4_id,   
								nivel4_nombre,   
								nivel4_visible,   
								nivel5_id,   
								nivel5_nombre,   
								nivel5_visible,   
								nivel6_id,   
								nivel6_nombre,   
								nivel6_visible)
							values 
								(:usuario,   
								:nombre_menu,   
								:linea,   
								:cont1,   
								:m1_nombre,   
								:m1_visible,   
								:cont2,   
								:m2_nombre,   
								:m2_visible,   
								:cont3,   
								:m3_nombre,   
								:m3_visible,   
								null,
								null,
								null,
								null,
								null,
								null,
								null,
								null,
								null);
							
							if sqlca.sqlcode = 0 then
								commit;
							else
								rollback;
							end if
							
						end if
					next
				else
					
					linea ++
					
					insert into menus  
						(usuario,   
						nombre_menu,   
						linea,   
						nivel1_id,   
						nivel1_nombre,   
						nivel1_visible,   
						nivel2_id,   
						nivel2_nombre,   
						nivel2_visible,   
						nivel3_id,   
						nivel3_nombre,   
						nivel3_visible,   
						nivel4_id,   
						nivel4_nombre,   
						nivel4_visible,   
						nivel5_id,   
						nivel5_nombre,   
						nivel5_visible,   
						nivel6_id,   
						nivel6_nombre,   
						nivel6_visible)
					values 
						(:usuario,   
						:nombre_menu,   
						:linea,   
						:cont1,   
						:m1_nombre,   
						:m1_visible,   
						:cont2,   
						:m2_nombre,   
						:m2_visible,   
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null);
					
					if sqlca.sqlcode = 0 then
						commit;
					else
						rollback;
					end if					
				end if
			next
		else
			
			linea ++
			
			insert into menus  
				(usuario,   
				nombre_menu,   
				linea,   
				nivel1_id,   
				nivel1_nombre,   
				nivel1_visible,   
				nivel2_id,   
				nivel2_nombre,   
				nivel2_visible,   
				nivel3_id,   
				nivel3_nombre,   
				nivel3_visible,   
				nivel4_id,   
				nivel4_nombre,   
				nivel4_visible,   
				nivel5_id,   
				nivel5_nombre,   
				nivel5_visible,   
				nivel6_id,   
				nivel6_nombre,   
				nivel6_visible)
			values 
				(:usuario,   
				:nombre_menu,   
				:linea,   
				:cont1,   
				:m1_nombre,   
				:m1_visible,   
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null);
			
			if sqlca.sqlcode = 0 then
				commit;
			else
				rollback;
			end if			
		end if
	next
	
	dw_1.retrieve(nombre_menu, usuario)
end if

end event

type gb_2 from groupbox within w_menuses
integer x = 1582
integer y = 2940
integer width = 453
integer height = 144
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Usuario"
end type

type gb_1 from groupbox within w_menuses
integer y = 2944
integer width = 1577
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Niveles"
end type

