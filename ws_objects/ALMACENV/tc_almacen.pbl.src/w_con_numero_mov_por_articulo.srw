$PBExportHeader$w_con_numero_mov_por_articulo.srw
forward
global type w_con_numero_mov_por_articulo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_numero_mov_por_articulo
end type
type pb_imprimir_preli from picturebutton within w_con_numero_mov_por_articulo
end type
type st_8 from statictext within w_con_numero_mov_por_articulo
end type
type em_fechadesde from u_em_campo within w_con_numero_mov_por_articulo
end type
type st_9 from statictext within w_con_numero_mov_por_articulo
end type
type em_fechahasta from u_em_campo within w_con_numero_mov_por_articulo
end type
type cb_consulta from u_boton within w_con_numero_mov_por_articulo
end type
type uo_familia from u_marca_lista within w_con_numero_mov_por_articulo
end type
type cb_4 from commandbutton within w_con_numero_mov_por_articulo
end type
type cbx_solo_con_movimientos from checkbox within w_con_numero_mov_por_articulo
end type
type ddlb_uso from dropdownlistbox within w_con_numero_mov_por_articulo
end type
type ddlb_promocion from dropdownlistbox within w_con_numero_mov_por_articulo
end type
type st_1 from statictext within w_con_numero_mov_por_articulo
end type
type em_f_alta_desde from u_em_campo within w_con_numero_mov_por_articulo
end type
type st_2 from statictext within w_con_numero_mov_por_articulo
end type
type em_f_alta_hasta from u_em_campo within w_con_numero_mov_por_articulo
end type
type cb_1 from u_boton within w_con_numero_mov_por_articulo
end type
type st_3 from statictext within w_con_numero_mov_por_articulo
end type
type st_4 from statictext within w_con_numero_mov_por_articulo
end type
type st_5 from statictext within w_con_numero_mov_por_articulo
end type
type st_6 from statictext within w_con_numero_mov_por_articulo
end type
type sle_a_plus from singlelineedit within w_con_numero_mov_por_articulo
end type
type sle_a from singlelineedit within w_con_numero_mov_por_articulo
end type
type sle_b from singlelineedit within w_con_numero_mov_por_articulo
end type
type sle_c from singlelineedit within w_con_numero_mov_por_articulo
end type
type sle_1 from singlelineedit within w_con_numero_mov_por_articulo
end type
type st_7 from statictext within w_con_numero_mov_por_articulo
end type
type cb_2 from u_boton within w_con_numero_mov_por_articulo
end type
type gb_1 from groupbox within w_con_numero_mov_por_articulo
end type
type gb_90 from groupbox within w_con_numero_mov_por_articulo
end type
type gb_22 from groupbox within w_con_numero_mov_por_articulo
end type
type gb_2 from groupbox within w_con_numero_mov_por_articulo
end type
type dw_1 from datawindow within w_con_numero_mov_por_articulo
end type
end forward

global type w_con_numero_mov_por_articulo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5193
integer height = 3740
pb_2 pb_2
pb_imprimir_preli pb_imprimir_preli
st_8 st_8
em_fechadesde em_fechadesde
st_9 st_9
em_fechahasta em_fechahasta
cb_consulta cb_consulta
uo_familia uo_familia
cb_4 cb_4
cbx_solo_con_movimientos cbx_solo_con_movimientos
ddlb_uso ddlb_uso
ddlb_promocion ddlb_promocion
st_1 st_1
em_f_alta_desde em_f_alta_desde
st_2 st_2
em_f_alta_hasta em_f_alta_hasta
cb_1 cb_1
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
sle_a_plus sle_a_plus
sle_a sle_a
sle_b sle_b
sle_c sle_c
sle_1 sle_1
st_7 st_7
cb_2 cb_2
gb_1 gb_1
gb_90 gb_90
gb_22 gb_22
gb_2 gb_2
dw_1 dw_1
end type
global w_con_numero_mov_por_articulo w_con_numero_mov_por_articulo

type variables
STRING  tipos[]
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);string   articulo,calidad,familias[]
long     indice,total,movimientos_pallets,movimientos_picos,movimientos, total_ubicaciones
long     total_movimientos_pallets,total_movimientos_picos,dias,indice_fam = 0
Datetime fecha_desde,fecha_hasta,fecha_alta, fecha_alta_desde , fecha_alta_hasta
string uso, promocion

dw_data.setredraw(false)

for indice = 1 to uo_familia.dw_marca.rowcount()
	if uo_familia.dw_marca.getitemstring(indice,"marca")="S" then	
		indice_fam ++
		familias[indice_fam] = uo_familia.dw_marca.getitemstring(indice,"codigo")
	end if
next

fecha_desde = Datetime(Date(em_fechadesde.Text))
fecha_hasta = Datetime(Date(em_fechahasta.Text))

fecha_alta_desde = Datetime(Date(em_f_alta_desde.Text))
fecha_alta_hasta = Datetime(Date(em_f_alta_hasta.Text))


dw_1.setfilter('')
dw_1.filter()

uso = ddlb_uso.text
//promocion = ddlb_promocion.text

if ddlb_promocion.text = 'Si' then
	promocion = 'S'
else
	if ddlb_promocion.text = 'No' then
		promocion = 'N'
	else
		promocion = '%'
	end if
end if	

dw_data.Retrieve(codigo_empresa, familias,uso, promocion, fecha_alta_desde, fecha_alta_hasta)
//dw_data.Retrieve(codigo_empresa,familias,fecha_desde,fecha_hasta)

total = dw_data.RowCount()


for indice = 1 to total
	f_mensaje_proceso("Procesando "+string(indice,"###,##0")+" de "+string(total,"###,##0"),indice,total)
	articulo   = dw_data.object.articulos_codigo[indice]
	calidad    = dw_data.object.almartcal_calidad[indice]
	fecha_alta = dw_data.object.fecha_alta[indice]
	
	if fecha_alta > fecha_desde then	
		dias = DaysAfter (date(fecha_alta),date(fecha_hasta))
	else
		dias = DaysAfter (date(fecha_desde),date(fecha_hasta))
	end if
	
	dias = (dias / 7) * 5
	if dias = 0 then dias = 1
	
	total_movimientos_pallets = 0
	total_movimientos_picos   = 0
	
	//Pedidos
/*	  NO QUIERO CONTEMPLAR LOS PEDIDOS
	select count(*)
	into   :movimientos_pallets
	from   venliped
	where  empresa  = :codigo_empresa
	and    articulo = :articulo
	and    calidad  = :calidad
	and    total_cajas > 0 
	and    cajas    = 0
	and    fpedido between :fecha_desde and :fecha_hasta;
	
	if isnull(movimientos_pallets) then movimientos_pallets = 0
	total_movimientos_pallets = total_movimientos_pallets + movimientos_pallets
	
	select count(*)
	into   :movimientos_picos
	from   venliped
	where  empresa  = :codigo_empresa
	and    articulo = :articulo
	and    calidad  = :calidad
	and    (total_cajas = 0 
	or      cajas    > 0)
	and    fpedido between :fecha_desde and :fecha_hasta;
	
	if isnull(movimientos_picos) then movimientos_picos = 0
	total_movimientos_picos = total_movimientos_picos + movimientos_picos
	*/
//	select count(*)
//	into   :movimientos
//	from   venliped
//	where  empresa  = :codigo_empresa
//	and    articulo = :articulo
//	and    calidad  = :calidad
//	and    fpedido between :fecha_desde and :fecha_hasta;
//	
//	if isnull(movimientos) then movimientos = 0
//	
//	if movimientos <> (movimientos_pallets + movimientos_picos) then
//		messagebox("Error","XXXXX~nTotal :"+string(movimientos,"###,##0")+" Calculado :"+string(movimientos_pallets + movimientos_picos,"###,##0"))
//	end if
	
	//Albaranes	
	
	select count(*)
	into   :movimientos_pallets
	from   venlialb
	inner join articulos on venlialb.empresa = articulos.empresa and venlialb.articulo = articulos.codigo
	where  venlialb.empresa  = :codigo_empresa
	and    articulo = :articulo
	and    calidad  = :calidad
	and    uso  = :uso
	and    promocion  like :promocion
	and    total_cajas > 0 
	and    cajas    = 0
	and    falbaran between :fecha_desde and :fecha_hasta;
	
	if isnull(movimientos_pallets) then movimientos_pallets = 0
	total_movimientos_pallets = total_movimientos_pallets + movimientos_pallets
	
	select count(*)
	into   :movimientos_picos
	from   venlialb
	inner join articulos on venlialb.empresa = articulos.empresa and venlialb.articulo = articulos.codigo
	where  venlialb.empresa  = :codigo_empresa
	and    articulo = :articulo
	and    calidad  = :calidad
	and    uso  = :uso
	and    promocion  like :promocion
	and    (total_cajas = 0 
	or      cajas    > 0)
	and    falbaran between :fecha_desde and :fecha_hasta;
	
	if isnull(movimientos_picos) then movimientos_picos = 0
	total_movimientos_picos = total_movimientos_picos + movimientos_picos
	

		
	//Facturas
	
	select count(*)
	into   :movimientos_pallets
	from   venlifac
	inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo
	where  venlifac.empresa  = :codigo_empresa
	and    articulo = :articulo
	and    calidad  = :calidad
	and    uso  = :uso
	and    promocion  like :promocion
	and    total_cajas > 0 
	and    cajas    = 0
	and    falbaran between :fecha_desde and :fecha_hasta;
	
	if isnull(movimientos_pallets) then movimientos_pallets = 0
	total_movimientos_pallets = total_movimientos_pallets + movimientos_pallets
	
	select count(*)
	into   :movimientos_picos
	from   venlifac
	inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo	
	where  venlifac.empresa  = :codigo_empresa
	and    articulo = :articulo
	and    calidad  = :calidad
	and    uso  = :uso
	and    promocion  like :promocion
	and    (total_cajas = 0 or cajas    > 0)
	and    falbaran between :fecha_desde and :fecha_hasta;
	
	if isnull(movimientos_picos) then movimientos_picos = 0
	total_movimientos_picos = total_movimientos_picos + movimientos_picos
	
	//Total bultos
	
	select count(*)
	into :total_ubicaciones
	from alm_bultos_lineas
	where empresa = :codigo_empresa
	and articulo = :articulo
	and calidad = :calidad;
	
	dw_data.object.ubicaciones[indice]     = total_ubicaciones
	dw_data.object.articulos_movimientos[indice]     = total_movimientos_pallets + total_movimientos_picos
	dw_data.object.articulos_pallets_enteros[indice] = total_movimientos_pallets
	dw_data.object.articulos_picos[indice]           = total_movimientos_picos
	dw_data.object.articulos_movimientos_dia[indice] = (total_movimientos_pallets + total_movimientos_picos) / dias

next
if cbx_solo_con_movimientos.checked then
	dw_1.setfilter('articulos_movimientos > 0')
	dw_1.filter()	
end if
dw_data.sort()
dw_data.groupcalc()
dw_data.setredraw(true)
end subroutine

event ue_listar;//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//CALL Super::ue_listar
end event

event open;call super::open;
This.title = " CONSULTA Nº DE MOVIMIENTOS POR ARTICULOS"

uo_familia.f_cargar_datos("dw_ayuda_familias","%","","Familia","Descripción")

em_fechadesde.text = String(RelativeDate ( Today(), -180 ) )
em_fechahasta.text = String(Today())

em_f_alta_desde.text = String('01-01-2001')   
em_f_alta_hasta.text = String(RelativeDate ( Today(), -180 ) )


dw_1.SetTransObject(sqlca)

//dw_listado.SetTransObject(sqlca)
//dw_listado.sharedata(dw_1)

em_fechadesde.Setfocus()

ddlb_uso.text = '3'
ddlb_promocion.text = 'N'
end event

on w_con_numero_mov_por_articulo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.em_fechahasta=create em_fechahasta
this.cb_consulta=create cb_consulta
this.uo_familia=create uo_familia
this.cb_4=create cb_4
this.cbx_solo_con_movimientos=create cbx_solo_con_movimientos
this.ddlb_uso=create ddlb_uso
this.ddlb_promocion=create ddlb_promocion
this.st_1=create st_1
this.em_f_alta_desde=create em_f_alta_desde
this.st_2=create st_2
this.em_f_alta_hasta=create em_f_alta_hasta
this.cb_1=create cb_1
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.sle_a_plus=create sle_a_plus
this.sle_a=create sle_a
this.sle_b=create sle_b
this.sle_c=create sle_c
this.sle_1=create sle_1
this.st_7=create st_7
this.cb_2=create cb_2
this.gb_1=create gb_1
this.gb_90=create gb_90
this.gb_22=create gb_22
this.gb_2=create gb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_imprimir_preli
this.Control[iCurrent+3]=this.st_8
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.st_9
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.cb_consulta
this.Control[iCurrent+8]=this.uo_familia
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cbx_solo_con_movimientos
this.Control[iCurrent+11]=this.ddlb_uso
this.Control[iCurrent+12]=this.ddlb_promocion
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.em_f_alta_desde
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.em_f_alta_hasta
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.st_3
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.st_5
this.Control[iCurrent+21]=this.st_6
this.Control[iCurrent+22]=this.sle_a_plus
this.Control[iCurrent+23]=this.sle_a
this.Control[iCurrent+24]=this.sle_b
this.Control[iCurrent+25]=this.sle_c
this.Control[iCurrent+26]=this.sle_1
this.Control[iCurrent+27]=this.st_7
this.Control[iCurrent+28]=this.cb_2
this.Control[iCurrent+29]=this.gb_1
this.Control[iCurrent+30]=this.gb_90
this.Control[iCurrent+31]=this.gb_22
this.Control[iCurrent+32]=this.gb_2
this.Control[iCurrent+33]=this.dw_1
end on

on w_con_numero_mov_por_articulo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_imprimir_preli)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.em_fechahasta)
destroy(this.cb_consulta)
destroy(this.uo_familia)
destroy(this.cb_4)
destroy(this.cbx_solo_con_movimientos)
destroy(this.ddlb_uso)
destroy(this.ddlb_promocion)
destroy(this.st_1)
destroy(this.em_f_alta_desde)
destroy(this.st_2)
destroy(this.em_f_alta_hasta)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.sle_a_plus)
destroy(this.sle_a)
destroy(this.sle_b)
destroy(this.sle_c)
destroy(this.sle_1)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.gb_90)
destroy(this.gb_22)
destroy(this.gb_2)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_numero_mov_por_articulo
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_numero_mov_por_articulo
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_numero_mov_por_articulo
integer width = 4914
end type

type pb_2 from upb_salir within w_con_numero_mov_por_articulo
integer x = 4965
integer y = 4
integer width = 128
integer height = 112
integer taborder = 0
end type

type pb_imprimir_preli from picturebutton within w_con_numero_mov_por_articulo
integer x = 4992
integer y = 164
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "\bmp\print.bmp"
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = "Fecha desde '"+em_fechadesde.text +"' Hasta '"+em_fechahasta.text+"'"
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

u_imp.event ue_imprimir(dw_1)

end event

type st_8 from statictext within w_con_numero_mov_por_articulo
integer x = 608
integer y = 136
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_numero_mov_por_articulo
integer x = 274
integer y = 136
integer width = 279
integer height = 76
integer taborder = 60
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_9 from statictext within w_con_numero_mov_por_articulo
integer x = 64
integer y = 136
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_numero_mov_por_articulo
integer x = 795
integer y = 136
integer width = 279
integer height = 76
integer taborder = 70
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_consulta from u_boton within w_con_numero_mov_por_articulo
integer x = 4457
integer y = 164
integer width = 480
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Consulta"
end type

event clicked;uo_familia.visible = false
f_cargar(dw_1)

end event

type uo_familia from u_marca_lista within w_con_numero_mov_por_articulo
event destroy ( )
boolean visible = false
integer x = 55
integer y = 312
integer width = 1353
integer height = 656
integer taborder = 170
boolean bringtotop = true
boolean border = false
end type

on uo_familia.destroy
call u_marca_lista::destroy
end on

type cb_4 from commandbutton within w_con_numero_mov_por_articulo
integer x = 1152
integer y = 128
integer width = 311
integer height = 88
integer taborder = 140
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;
 uo_familia.visible = not(uo_familia.visible)

end event

type cbx_solo_con_movimientos from checkbox within w_con_numero_mov_por_articulo
integer x = 1563
integer y = 124
integer width = 439
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Solo con Mov."
end type

event clicked;if cbx_solo_con_movimientos.checked then
	dw_1.setfilter('articulos_movimientos > 0')
else
	dw_1.setfilter('')
end if

dw_1.filter()
end event

type ddlb_uso from dropdownlistbox within w_con_numero_mov_por_articulo
integer x = 1189
integer y = 304
integer width = 361
integer height = 300
integer taborder = 180
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"1","2","3",""}
borderstyle borderstyle = stylelowered!
end type

type ddlb_promocion from dropdownlistbox within w_con_numero_mov_por_articulo
integer x = 1623
integer y = 304
integer width = 274
integer height = 300
integer taborder = 190
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Si","No","Todo"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_con_numero_mov_por_articulo
integer x = 64
integer y = 292
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_f_alta_desde from u_em_campo within w_con_numero_mov_por_articulo
integer x = 274
integer y = 292
integer width = 279
integer height = 76
integer taborder = 80
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_con_numero_mov_por_articulo
integer x = 608
integer y = 292
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_f_alta_hasta from u_em_campo within w_con_numero_mov_por_articulo
integer x = 795
integer y = 292
integer width = 279
integer height = 76
integer taborder = 90
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from u_boton within w_con_numero_mov_por_articulo
integer x = 3104
integer y = 184
integer width = 361
integer height = 148
integer taborder = 120
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Asignar "
end type

event clicked;long i 

for i = 1 to dw_1.rowcount()
	choose case dw_1.Object.porcentaje_acumulado [i] 
		case is < dec (sle_a_plus.text)
			dw_1.Object.tipo_abc [i] = "A+"
		case is < dec (sle_a.text)
			dw_1.Object.tipo_abc [i] = "A"
		case is < dec (sle_b.text) 
			dw_1.Object.tipo_abc [i] = "B"
		case else
			dw_1.Object.tipo_abc [i] = "C"
	end choose
next




end event

type st_3 from statictext within w_con_numero_mov_por_articulo
integer x = 2386
integer y = 96
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo A+  <="
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_numero_mov_por_articulo
integer x = 2386
integer y = 168
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo A    <="
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_numero_mov_por_articulo
integer x = 2386
integer y = 240
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo B    <="
boolean focusrectangle = false
end type

type st_6 from statictext within w_con_numero_mov_por_articulo
integer x = 2386
integer y = 312
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo C    <="
boolean focusrectangle = false
end type

type sle_a_plus from singlelineedit within w_con_numero_mov_por_articulo
integer x = 2729
integer y = 88
integer width = 169
integer height = 68
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "50"
borderstyle borderstyle = stylelowered!
end type

type sle_a from singlelineedit within w_con_numero_mov_por_articulo
integer x = 2729
integer y = 160
integer width = 169
integer height = 68
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "80"
borderstyle borderstyle = stylelowered!
end type

type sle_b from singlelineedit within w_con_numero_mov_por_articulo
integer x = 2729
integer y = 232
integer width = 169
integer height = 68
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "95"
borderstyle borderstyle = stylelowered!
end type

type sle_c from singlelineedit within w_con_numero_mov_por_articulo
integer x = 2729
integer y = 304
integer width = 169
integer height = 68
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_con_numero_mov_por_articulo
integer x = 3511
integer y = 92
integer width = 151
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1.5"
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_con_numero_mov_por_articulo
integer x = 2971
integer y = 96
integer width = 521
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Corrección Picking:"
boolean focusrectangle = false
end type

type cb_2 from u_boton within w_con_numero_mov_por_articulo
integer x = 3689
integer y = 188
integer width = 361
integer height = 148
integer taborder = 130
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;long i 
string articulo
string tipo_abc


update articulos set tipo_abc = 'A'
where empresa = :codigo_empresa;
commit using SQLCA;
for i = 1 to dw_1.rowcount()
	articulo = dw_1.object.articulos_codigo[i]
	tipo_abc = dw_1.object.tipo_abc[i]
	update articulos
	set tipo_abc = :tipo_abc
	where empresa = :codigo_empresa
	and codigo = :articulo;
	
	//if articulo = '99288' then	MessageBox(tipo_Abc, "Articulo: "+articulo)		
	
	IF SQLCA.SQLCode = -1 	THEN         
		MessageBox("SQL error", SQLCA.SQLErrText+"          Articulo: "+articulo)
		rollback using SQLCA;
	ELSE
		commit using SQLCA;
	END IF
	f_mensaje_proceso ("Regs",i, dw_1.rowcount())	
next




end event

type gb_1 from groupbox within w_con_numero_mov_por_articulo
integer x = 37
integer y = 76
integer width = 1061
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Movimiento"
end type

type gb_90 from groupbox within w_con_numero_mov_por_articulo
integer x = 1175
integer y = 244
integer width = 389
integer height = 160
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Tipo Prod."
end type

type gb_22 from groupbox within w_con_numero_mov_por_articulo
integer x = 1577
integer y = 244
integer width = 370
integer height = 160
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Promoción"
end type

type gb_2 from groupbox within w_con_numero_mov_por_articulo
integer x = 37
integer y = 232
integer width = 1061
integer height = 144
integer taborder = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Alta"
end type

type dw_1 from datawindow within w_con_numero_mov_por_articulo
integer x = 41
integer y = 428
integer width = 5106
integer height = 3160
integer taborder = 110
string dataobject = "dw_con_numero_mov_por_articulo"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;if dwo.name = 'orden_movimientos' then
	dw_1.setsort("articulos_movimientos D,descripcion,formatos_abreviado,almartcal_calidad")
	dw_1.sort()
	dw_1.modify("orden_movimientos.color = '"+string(rgb(255,0,0),"############")+"'")
	dw_1.modify("orden_movimientos_dia.color = '"+string(rgb(0,0,255),"############")+"'")
	dw_1.modify("orden_pallets.color = '"+string(rgb(0,0,255),"############")+"'")
	dw_1.modify("orden_picos.color = '"+string(rgb(0,0,255),"############")+"'")
	dw_1.modify("orden_movimientos_corregidos.color = '"+string(rgb(0,0,255),"############")+"'")
else
	if dwo.name = 'orden_movimientos_corregidos' then
		dw_1.setsort("articulos_movimientos_corregidos D,descripcion,formatos_abreviado,almartcal_calidad")
		dw_1.sort()		
		dw_1.modify("orden_movimientos.color = '"+string(rgb(0,0,255),"############")+"'")
		dw_1.modify("orden_movimientos_dia.color = '"+string(rgb(255,0,0),"############")+"'")
		dw_1.modify("orden_pallets.color = '"+string(rgb(0,0,255),"############")+"'")
		dw_1.modify("orden_picos.color = '"+string(rgb(0,0,255),"############")+"'")		
		dw_1.modify("orden_movimientos_corregidos.color = '"+string(rgb(255,0,0),"############")+"'")	

	else
		if dwo.name = 'orden_movimientos_dia' then
			dw_1.setsort("articulos_movimientos_dia D,descripcion,formatos_abreviado,almartcal_calidad")
			dw_1.sort()		
			dw_1.modify("orden_movimientos.color = '"+string(rgb(0,0,255),"############")+"'")
			dw_1.modify("orden_movimientos_dia.color = '"+string(rgb(255,0,0),"############")+"'")
			dw_1.modify("orden_pallets.color = '"+string(rgb(0,0,255),"############")+"'")
			dw_1.modify("orden_picos.color = '"+string(rgb(0,0,255),"############")+"'")	
			dw_1.modify("orden_movimientos_corregidos.color = '"+string(rgb(0,0,255),"############")+"'")		
			
		else
			if dwo.name = 'orden_pallets' then
				dw_1.setsort("articulos_pallets_enteros D,descripcion,formatos_abreviado,almartcal_calidad")
				dw_1.sort()		
				dw_1.modify("orden_movimientos.color = '"+string(rgb(0,0,255),"############")+"'")
				dw_1.modify("orden_movimientos_dia.color = '"+string(rgb(0,0,255),"############")+"'")
				dw_1.modify("orden_pallets.color = '"+string(rgb(255,0,0),"############")+"'")
				dw_1.modify("orden_picos.color = '"+string(rgb(0,0,255),"############")+"'")	
				dw_1.modify("orden_movimientos_corregidos.color = '"+string(rgb(0,0,255),"############")+"'")			
				
			else
				if dwo.name = 'orden_picos' then
					dw_1.setsort("articulos_picos D,descripcion,formatos_abreviado,almartcal_calidad")
					dw_1.sort()		
					dw_1.modify("orden_movimientos.color = '"+string(rgb(0,0,255),"############")+"'")
					dw_1.modify("orden_movimientos_dia.color = '"+string(rgb(0,0,255),"############")+"'")
					dw_1.modify("orden_pallets.color = '"+string(rgb(0,0,255),"############")+"'")
					dw_1.modify("orden_picos.color = '"+string(rgb(255,0,0),"############")+"'")				
					dw_1.modify("orden_movimientos_corregidos.color = '"+string(rgb(0,0,255),"############")+"'")		
				end if			
			end if		
		end if
	end if
	end if
end event

