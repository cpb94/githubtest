$PBExportHeader$w_con_invent_dif.srw
$PBExportComments$Consulta diferencias de inventarios.
forward
global type w_con_invent_dif from w_int_con_empresa
end type
type st_2 from statictext within w_con_invent_dif
end type
type dw_1 from datawindow within w_con_invent_dif
end type
type pb_1 from upb_salir within w_con_invent_dif
end type
type cb_2 from u_boton within w_con_invent_dif
end type
type cb_3 from u_boton within w_con_invent_dif
end type
type report_alminvent from datawindow within w_con_invent_dif
end type
type dw_proceso from datawindow within w_con_invent_dif
end type
type metros from u_em_campo within w_con_invent_dif
end type
type em_periodo from u_em_campo within w_con_invent_dif
end type
type unidades from u_em_campo within w_con_invent_dif
end type
type st_3 from statictext within w_con_invent_dif
end type
type st_4 from statictext within w_con_invent_dif
end type
type dw_inv from u_datawindow within w_con_invent_dif
end type
type uo_1 from u_em_campo_2 within w_con_invent_dif
end type
type st_1 from statictext within w_con_invent_dif
end type
type gb_1 from groupbox within w_con_invent_dif
end type
end forward

global type w_con_invent_dif from w_int_con_empresa
integer width = 2921
integer height = 1636
st_2 st_2
dw_1 dw_1
pb_1 pb_1
cb_2 cb_2
cb_3 cb_3
report_alminvent report_alminvent
dw_proceso dw_proceso
metros metros
em_periodo em_periodo
unidades unidades
st_3 st_3
st_4 st_4
dw_inv dw_inv
uo_1 uo_1
st_1 st_1
gb_1 gb_1
end type
global w_con_invent_dif w_con_invent_dif

type variables
String filtro

end variables

forward prototypes
public subroutine f_cargar (datawindow dt, string list)
end prototypes

public subroutine f_cargar (datawindow dt, string list);Integer contador,y1,r1,r,cont,ln

String referenciat,tipo_pallett,val,articulo,calidad,n_articulo,familia,formato,cri
Dec fisico,contable,tono,calibre,calibret,tonot,pallets,cajas
f_mascara_columna(dt,"t1",f_mascara_decimales(2))
f_mascara_columna(dt,"t2",f_mascara_decimales(2))
f_mascara_columna(dt,"t3",f_mascara_decimales(2))
f_mascara_columna(dt,"t4",f_mascara_decimales(2))
f_mascara_columna(dt,"t5",f_mascara_decimales(2))
f_mascara_columna(dt,"t6",f_mascara_decimales(2))
cont = 0
dt.Retrieve(codigo_empresa)
dt.SetRedraw(FALSE)
//if list = "S" then dt.visible = TRUE

f_mensaje_proceso("Seleccionando...",1,100)
String referencia,tipo_pallet,sel,mas
IF Trim(uo_1.em_codigo.text) = "" Then
	mas = ""
ELSE
	mas = " And almacen = '" + Trim(uo_1.em_codigo.text) + "'"
END IF
DataStore data 
Decimal{4} diferencia,total_difinv
sel = " Select * from alminvent " +&
		" Where empresa = '" + codigo_empresa + "'" +&
		" And   fecha_inv = '"+ String(Date(dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv")),"dd/mm/yyyy")+"'" +&
		+mas+&
		" And   (referencia <> referenciat or tipo_pallet <> tipo_pallett or existencias <> existenciast) " +&
		" ANd activo = 'S'"

//data = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, data)


contador = data.RowCOunt()
For y1 =1 To contador
f_mensaje_proceso("Grabando Diferencias...",y1,contador)
referencia        = data.GetItemString(y1,"referencia")
articulo        	= f_articulo_referencia(referencia)
calidad        	= f_calidad_referencia(referencia)
referenciat       = data.GetItemString(y1,"referenciat")
tipo_pallet       = data.GetItemString(y1,"tipo_pallet")
tipo_pallett      = data.GetItemString(y1,"tipo_pallett")
tono          		= Dec(f_tono_referencia(referencia))
calibre           = Dec(f_calibre_referencia(referencia))
tonot             = Dec(f_tono_referencia(referenciat))
calibret          = Dec(f_calibre_referencia(referenciat))
fisico            = data.GetItemNumber(y1,"existencias")
contable          = data.GetItemNumber(y1,"existenciast")
r1 = 1
IF referencia <> referenciat or tipo_pallet <> tipo_pallett Then r1 = 2
For r = 1 To r1
val = "S"
IF r1 = 2 and r = 1 Then 
	fisico            = data.GetItemNumber(y1,"existencias")
	contable = 0
END IF
IF r1 = 2 and r = 2 Then 
	contable          = data.GetItemNumber(y1,"existenciast")
	fisico = 0
	tipo_pallet = tipo_pallett
	tono        = tonot
	calibre     = calibret
	referencia  = referenciat
END IF
diferencia = fisico - contable
//IF diferencia < 0 Then diferencia=diferencia * (-1)

 IF f_codigo_articulo_unidad(codigo_empresa,f_referencia_codarticulo(referencia)) = "0" Then
  IF Abs(diferencia) <= Dec(unidades.text) Then
		val = "N"
  END IF
 END IF
 
 IF f_codigo_articulo_unidad(codigo_empresa,f_referencia_codarticulo(referencia)) = "1" Then
  IF Abs(diferencia) <= Dec(metros.text) Then
		val = "N"
  END IF
 END IF
 IF val = "S" Then 
	cri = " codigo_articulo ='"+articulo+"' and codigo_calidad ='"+calidad+"'"+&
			" and  tono   = "  + string(tono,"#0")+ &
			" and calibre = "  + string(calibre,"#0") +" and codigo_tipo_pallet ='"+ tipo_pallet +"'"


	ln =  dt.find(cri,1,dt.RowCount()) 
	IF ln = 0 Then
		cont = cont +1
		dt.InsertRow(cont)
		Select descripcion,familia,formato 
		Into :n_articulo,:familia,:formato 
		From  articulos
		Where  empresa = :codigo_empresa
		And    codigo  = :articulo;
		dt.SetItem(cont,"codigo_articulo",articulo)
		dt.SetItem(cont,"articulo",n_articulo)
		dt.SetItem(cont,"formato",f_nombre_formato_abr(codigo_empresa,formato))
		dt.SetItem(cont,"familia",f_nombre_familia(codigo_empresa,familia))
		dt.SetItem(cont,"codigo_calidad",calidad)
		dt.SetItem(cont,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
		dt.SetItem(cont,"tono",tono)
		dt.SetItem(cont,"calibre",calibre)
		dt.SetItem(cont,"codigo_tipo_pallet",tipo_pallet)
		dt.SetItem(cont,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
		fisico = f_existencias_alminvent(codigo_empresa,dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"),referencia,tipo_pallet)
		contable= f_existenciast_alminvent(codigo_empresa,dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"),referencia,tipo_pallet)
		diferencia = fisico - contable
		dt.SetItem(cont,"fisico",fisico)
		dt.SetItem(cont,"contable",contable)
		dt.SetItem(cont,"diferencia",diferencia)
		IF list = "S" Then
			//pallets = f_calculo_pallets(codigo_empresa,articulo,tipo_pallet,diferencia)
			//dt.SetItem(cont,"pallets",pallets)
			//cajas = f_calculo_cajas(codigo_empresa,articulo,tipo_pallet,pallets,diferencia)
			//dt.SetItem(cont,"cajas",cajas)
		END IF
	END IF
	
 END IF
Next
Next
dt.SetSort("familia,formato,articulo,calidad,tono,calibre")
dt.Sort()
dt.GroupCalc()
dt.SetRedraw(TRUE)
IF list = "S" Then dt.visible = FALSE

destroy data


      

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias inventarios"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_inv.settransobject(SQLCA)
dw_proceso.settransobject(SQLCA)
report_alminvent.settransobject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator

em_periodo.text=String(year(today()))
dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
f_mascara_columna(dw_inv,"c1",f_mascara_decimales(2))
f_mascara_columna(dw_inv,"c2",f_mascara_decimales(2))
f_mascara_columna(dw_inv,"c3",f_mascara_decimales(2))
f_mascara_columna(report_alminvent,"con1",f_mascara_decimales(2))
f_mascara_columna(report_alminvent,"fisi1",f_mascara_decimales(2))
f_mascara_columna(report_alminvent,"dif",f_mascara_decimales(2))







end event

on w_con_invent_dif.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_1=create dw_1
this.pb_1=create pb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.report_alminvent=create report_alminvent
this.dw_proceso=create dw_proceso
this.metros=create metros
this.em_periodo=create em_periodo
this.unidades=create unidades
this.st_3=create st_3
this.st_4=create st_4
this.dw_inv=create dw_inv
this.uo_1=create uo_1
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.report_alminvent
this.Control[iCurrent+7]=this.dw_proceso
this.Control[iCurrent+8]=this.metros
this.Control[iCurrent+9]=this.em_periodo
this.Control[iCurrent+10]=this.unidades
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.dw_inv
this.Control[iCurrent+14]=this.uo_1
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.gb_1
end on

on w_con_invent_dif.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.pb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.report_alminvent)
destroy(this.dw_proceso)
destroy(this.metros)
destroy(this.em_periodo)
destroy(this.unidades)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_inv)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.gb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_inv)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_inv)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_inv)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_inv)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_invent_dif
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_invent_dif
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_invent_dif
integer y = 20
integer width = 2661
integer height = 108
end type

type st_2 from statictext within w_con_invent_dif
integer y = 160
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Periodo"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_invent_dif
integer x = 590
integer y = 140
integer width = 777
integer height = 284
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_con_invent_dif1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on getfocus;This.BorderStyle=StyleLowered!
end on

on losefocus;This.BorderStyle=StyleRaised!
end on

type pb_1 from upb_salir within w_con_invent_dif
integer x = 2706
integer y = 16
integer width = 119
integer height = 120
integer taborder = 0
end type

type cb_2 from u_boton within w_con_invent_dif
integer x = 2409
integer y = 236
integer width = 389
integer height = 88
integer taborder = 50
string text = "&Consultar"
end type

event clicked;call super::clicked;f_cargar(dw_inv,"N")		
end event

type cb_3 from u_boton within w_con_invent_dif
integer x = 2409
integer y = 324
integer width = 389
integer height = 84
integer taborder = 60
string text = "&Imprimir"
end type

event clicked;call super::clicked;f_cargar(report_alminvent,"S")
f_imprimir_datawindow(report_alminvent)      
end event

type report_alminvent from datawindow within w_con_invent_dif
boolean visible = false
integer y = 280
integer width = 494
integer height = 164
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_invent_dif"
boolean livescroll = true
end type

type dw_proceso from datawindow within w_con_invent_dif
boolean visible = false
integer x = 9
integer width = 494
integer height = 264
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_proceso_tipo_unidades"
boolean livescroll = true
end type

type metros from u_em_campo within w_con_invent_dif
event modified pbm_enmodified
integer x = 1682
integer y = 164
integer width = 261
integer taborder = 0
string text = "0"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0.00"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type em_periodo from u_em_campo within w_con_invent_dif
integer x = 302
integer y = 148
integer width = 256
integer taborder = 20
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type unidades from u_em_campo within w_con_invent_dif
event modified pbm_enmodified
integer x = 1682
integer y = 252
integer width = 261
integer taborder = 0
string text = "0"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0.00"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type st_3 from statictext within w_con_invent_dif
integer x = 1394
integer y = 176
integer width = 229
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Metros:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_invent_dif
integer x = 1394
integer y = 252
integer width = 229
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Unid:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_inv from u_datawindow within w_con_invent_dif
integer y = 432
integer width = 2853
integer height = 992
integer taborder = 0
string dataobject = "dw_con_invent_dif2"
borderstyle borderstyle = styleraised!
end type

event ue_valores;call super::ue_valores;ue_marca_linea = TRUE
end event

event clicked;call super::clicked;	str_parametros str
	str.s_argumentos[1]= "w_con_invent_dif"
IF f_objeto_datawindow(This) = "stock" Then
	str.s_argumentos[2]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_articulo")
	str.s_argumentos[3]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_calidad")
	str.s_argumentos[6]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_tipo_pallet")
	str.i_nargumentos = 6
	OpenWithParm(w_con_stock_articulos,str)
END IF

IF f_objeto_datawindow(This) = "entradas" Then
	str.s_argumentos[2]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_articulo")
	str.s_argumentos[3]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_calidad")
	str.s_argumentos[4]= String(dw_inv.GetItemNumber(dw_inv.GetRow(),"tono"))
	str.s_argumentos[5]= String(dw_inv.GetItemNumber(dw_inv.GetRow(),"calibre"))
	str.s_argumentos[6]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_tipo_pallet")
	str.i_nargumentos = 6
	OpenWithParm(w_con_mov_entradas_inventario,str)
END IF

IF f_objeto_datawindow(This) = "salidas" Then
str.s_argumentos[2]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_articulo")
	str.s_argumentos[3]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_calidad")
	str.s_argumentos[4]= String(dw_inv.GetItemNumber(dw_inv.GetRow(),"tono"))
	str.s_argumentos[5]= String(dw_inv.GetItemNumber(dw_inv.GetRow(),"calibre"))
	str.s_argumentos[6]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_tipo_pallet")
	str.i_nargumentos = 6
	OpenWithParm(w_con_mov_salidas_inventario,str)
END IF

IF f_objeto_datawindow(This) = "detalle" Then
	str.s_argumentos[2]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_articulo")
	str.s_argumentos[3]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_calidad")
	str.s_argumentos[4]= String(dw_inv.GetItemNumber(dw_inv.GetRow(),"tono"))
	str.s_argumentos[5]= String(dw_inv.GetItemNumber(dw_inv.GetRow(),"calibre"))
	str.s_argumentos[6]= dw_inv.GetItemString(dw_inv.GetRow(),"codigo_tipo_pallet")
	str.s_argumentos[7]= String(Date(dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv")),"dd/mm/yyyy")
	str.i_nargumentos = 7
	OpenWithParm(w_con_alminvent_articulo,str)
END IF

end event

type uo_1 from u_em_campo_2 within w_con_invent_dif
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1682
integer y = 336
integer width = 663
integer height = 80
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_1.em_campo.text=f_nombre_almacen(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Almacenes"
ue_datawindow ="dw_ayuda_almacenes"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within w_con_invent_dif
integer x = 1403
integer y = 340
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Almacen"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_invent_dif
integer x = 2395
integer y = 192
integer width = 416
integer height = 228
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

