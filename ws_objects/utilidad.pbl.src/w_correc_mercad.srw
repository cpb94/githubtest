$PBExportHeader$w_correc_mercad.srw
forward
global type w_correc_mercad from window
end type
type st_4 from statictext within w_correc_mercad
end type
type st_3 from statictext within w_correc_mercad
end type
type st_2 from statictext within w_correc_mercad
end type
type cb_1 from commandbutton within w_correc_mercad
end type
type st_1 from statictext within w_correc_mercad
end type
type em_mes from u_em_campo within w_correc_mercad
end type
type dw_1 from datawindow within w_correc_mercad
end type
end forward

global type w_correc_mercad from window
integer x = 654
integer y = 268
integer width = 2373
integer height = 1160
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_4 st_4
st_3 st_3
st_2 st_2
cb_1 cb_1
st_1 st_1
em_mes em_mes
dw_1 dw_1
end type
global w_correc_mercad w_correc_mercad

event open;dw_1.SetTransObject(sqlca)
end event

on w_correc_mercad.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_1=create cb_1
this.st_1=create st_1
this.em_mes=create em_mes
this.dw_1=create dw_1
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.cb_1,&
this.st_1,&
this.em_mes,&
this.dw_1}
end on

on w_correc_mercad.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_mes)
destroy(this.dw_1)
end on

type st_4 from statictext within w_correc_mercad
integer x = 1490
integer y = 40
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_3 from statictext within w_correc_mercad
integer x = 1225
integer y = 40
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "de"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_correc_mercad
integer x = 960
integer y = 40
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_correc_mercad
integer x = 562
integer y = 40
integer width = 311
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "procesar"
end type

event clicked;datastore dd
String sel,v_articulo,v_calidad,v_tipopallet,v_caja
Integer v_tono,v_calibre,resp
Dec cont,v_factura,v_linea
boolean bien=true

dw_1.reset()
sel =" SELECT factura,linea_factura,articulo,calidad,tono,calibre,tipo_pallet,caja "+&
 	  " FROM venlifac " +&
	  " WHERE empresa = '" +codigo_empresa + "' "+&
	  " AND anyo = 1998 "+&
	  " AND mes =" + em_mes.text+&
	  " ORDER BY anyo,factura,linea_factura" 
	  
	  
//dd = f_cargar_cursor(sel)
f_cargar_cursor_nuevo (sel, dd)

st_4.text = String(dd.RowCount(),"#,###")
for cont = 1 to dd.RowCount() 
	st_2.text = String(cont,"#,###")
	v_articulo  = dd.GetItemString(cont,"articulo")
	v_calidad   = dd.GetItemString(cont,"calidad")
	v_tono      = dd.GetItemNumber(cont,"tono")
	v_calibre   = dd.GetItemNumber(cont,"calibre")
	v_tipopallet= dd.GetItemString(cont,"tipo_pallet")
	v_caja      = dd.GetItemString(cont,"caja")	

	dw_1.retrieve(codigo_empresa,v_articulo,v_calidad,v_tono,v_calibre,v_tipopallet,v_caja)
	resp = MessageBox("Atención pregunta", "¿Mercaderías?", &
		Exclamation!, YesNo!, 2)
	IF resp = 1 THEN
 	// Es mercadería, luego hay que cambiar el tipo de línea a 7
	 	v_factura = dd.GetItemNumber(cont,"factura")
	 	v_linea   = dd.GetItemNumber(cont,"linea_factura")
		 update venlifac
		 set tipolinea ="7"
		 where empresa  = :codigo_empresa
		 and anyo = 1998
		 and factura = :v_factura
		 and linea_factura = :v_linea
		 using sqlca;
		 if sqlca.sqlcode = 0 then
			bien=true
		else 
			f_mensaje ("error","en update venlifac")
			bien=false
		end if
	ELSE
 	// Es PT, no se cambia el tipo de línea
	END IF
	
next

destroy dd
if  bien then
	COMMIT;
else 
	ROLLBACK;
end if
end event

type st_1 from statictext within w_correc_mercad
integer x = 69
integer y = 40
integer width = 160
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "mes"
boolean focusrectangle = false
end type

type em_mes from u_em_campo within w_correc_mercad
integer x = 247
integer y = 36
integer taborder = 10
end type

type dw_1 from datawindow within w_correc_mercad
integer x = 50
integer y = 152
integer width = 2272
integer height = 872
integer taborder = 20
string dataobject = "dw_correc_mercad"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

