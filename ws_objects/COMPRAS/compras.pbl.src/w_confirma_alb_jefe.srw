$PBExportHeader$w_confirma_alb_jefe.srw
$PBExportComments$Confirmacion del jefe de albaranes confirmados
forward
global type w_confirma_alb_jefe from w_int_con_empresa
end type
type pb_1 from upb_salir within w_confirma_alb_jefe
end type
type uo_proveedor from u_em_campo_2 within w_confirma_alb_jefe
end type
type uo_manejo from u_manejo_datawindow within w_confirma_alb_jefe
end type
type gb_5 from groupbox within w_confirma_alb_jefe
end type
type gb_1 from groupbox within w_confirma_alb_jefe
end type
type cb_1 from commandbutton within w_confirma_alb_jefe
end type
type cb_2 from commandbutton within w_confirma_alb_jefe
end type
type em_anyo2 from u_em_campo within w_confirma_alb_jefe
end type
type em_alb from u_em_campo within w_confirma_alb_jefe
end type
type uo_mprima from u_em_campo_2 within w_confirma_alb_jefe
end type
type gb_2 from groupbox within w_confirma_alb_jefe
end type
type st_8 from statictext within w_confirma_alb_jefe
end type
type gb_3 from groupbox within w_confirma_alb_jefe
end type
type cb_3 from commandbutton within w_confirma_alb_jefe
end type
type gb_6 from groupbox within w_confirma_alb_jefe
end type
type dw_1 from datawindow within w_confirma_alb_jefe
end type
end forward

shared variables
string pul='N'
end variables

global type w_confirma_alb_jefe from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 2985
integer height = 1520
string icon = "Application!"
pb_1 pb_1
uo_proveedor uo_proveedor
uo_manejo uo_manejo
gb_5 gb_5
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
em_anyo2 em_anyo2
em_alb em_alb
uo_mprima uo_mprima
gb_2 gb_2
st_8 st_8
gb_3 gb_3
cb_3 cb_3
gb_6 gb_6
dw_1 dw_1
end type
global w_confirma_alb_jefe w_confirma_alb_jefe

type variables
  integer contador,v_altura,v_fila,anyo
  decimal{4} v_cantidad, cantidad
  decimal{4} ante_valor
  String v_almacen,v_zona,cod_sector,v_lote
  string ante_numdoc
  String situado,mprima,albaran,linea_alb,unidad
  datetime fecha
  Boolean  control_tono,control_calibre
// Defino la estructura de la tablas a procesar
   str_almlinubicahis  ubihis
   str_almlinubica      ubi
   str_almmovhis       mov
end variables

forward prototypes
public function string f_filtro ()
end prototypes

public function string f_filtro ();string filtro,f_a,f_mp,f_p

if em_alb.text="" or isnull(em_alb.text) then
	f_a=""
else
	f_a="(comlinalb_albaran = '"+trim(em_alb.text)+"') and (comlinalb_anyo = '" +trim(em_anyo2.text)+"')"
end if

if uo_proveedor.em_codigo.text="" or isnull(uo_proveedor.em_codigo.text) then
	f_p=""
else
	f_p="(comcabalb_proveedor = '"+trim(uo_proveedor.em_codigo.text)+"')"
end if

if uo_mprima.em_codigo.text="" or isnull(uo_mprima.em_codigo.text) then
	f_mp=""
else
	f_mp="(comlinalb_mprima = '"+trim(uo_mprima.em_codigo.text)+"')"
end if

if f_a="" then
	if f_mp="" then
		if f_p="" then
			filtro=""
		else
			filtro= f_p
		end if
	else
		if f_p="" then
			filtro= f_mp
		else
			filtro= "(" + f_mp + " and " + f_p + ")"
		end if
	end if
else
	if f_mp="" then
		if f_p="" then
			filtro= f_a
		else
			filtro= "(" + f_a + " and " + f_p + ")"
		end if
	else
		if f_p="" then
			filtro= "(" + f_a + " and " + f_mp + ")"
		else
			filtro= "(" + f_a + " and " + f_mp + " and " + f_p + ")"
		end if
	end if
end if	

return filtro
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Confirmación de Albaranes"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
em_anyo2.text=string(year(today()))
f_activar_campo(uo_proveedor.em_campo)
end event

event ue_listar;//dw_listado_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text)
//dw_report=dw_listado_proveedores
//CALL Super::ue_listar
end event

on w_confirma_alb_jefe.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_proveedor=create uo_proveedor
this.uo_manejo=create uo_manejo
this.gb_5=create gb_5
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.em_anyo2=create em_anyo2
this.em_alb=create em_alb
this.uo_mprima=create uo_mprima
this.gb_2=create gb_2
this.st_8=create st_8
this.gb_3=create gb_3
this.cb_3=create cb_3
this.gb_6=create gb_6
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_proveedor
this.Control[iCurrent+3]=this.uo_manejo
this.Control[iCurrent+4]=this.gb_5
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.em_anyo2
this.Control[iCurrent+9]=this.em_alb
this.Control[iCurrent+10]=this.uo_mprima
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.st_8
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.cb_3
this.Control[iCurrent+15]=this.gb_6
this.Control[iCurrent+16]=this.dw_1
end on

on w_confirma_alb_jefe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_proveedor)
destroy(this.uo_manejo)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.em_anyo2)
destroy(this.em_alb)
destroy(this.uo_mprima)
destroy(this.gb_2)
destroy(this.st_8)
destroy(this.gb_3)
destroy(this.cb_3)
destroy(this.gb_6)
destroy(this.dw_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_confirma_alb_jefe
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_confirma_alb_jefe
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_confirma_alb_jefe
integer x = 50
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_confirma_alb_jefe
integer x = 2752
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_proveedor from u_em_campo_2 within w_confirma_alb_jefe
integer x = 1609
integer y = 204
integer width = 882
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)
IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type uo_manejo from u_manejo_datawindow within w_confirma_alb_jefe
event valores pbm_custom01
boolean visible = false
integer x = 1646
integer y = 100
integer width = 613
end type

event valores;call super::valores;dw_data=dw_1
f_activar_campo(uo_proveedor.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_5 from groupbox within w_confirma_alb_jefe
integer x = 2533
integer y = 116
integer width = 343
integer height = 200
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_confirma_alb_jefe
integer x = 1563
integer y = 116
integer width = 969
integer height = 200
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
end type

type cb_1 from commandbutton within w_confirma_alb_jefe
integer x = 14
integer y = 476
integer width = 315
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;Long   bien
Long   total_lineas,i,linea=0
String proceso

total_lineas=dw_1.rowcount()

/**********************************************************************/
/*						PROCESO POR CADA LÍNEA DE DW_1                      */
/**********************************************************************/

FOR i=1 TO total_lineas
	
	proceso=dw_1.getitemstring(i,"comlinalb_libre")

	IF proceso = "B" THEN		// Linea OK
		
		String   anyo_st, pedido, linped
		String   obs, anyo_ped, provee
		DateTime frech, fech_control
		Dec      precio
		boolean ok
		
		anyo_st   = dw_1.GetItemString(i,"comlinalb_anyo")
		albaran   = dw_1.GetItemString(i,"comlinalb_albaran")
		linea_alb = dw_1.GetItemString(i,"comlinalb_linea")
		fech_control=datetime(today(),now())
		UPDATE comlinalb SET situacion    = 'F',
						 			fecha_control= :fech_control				
   	WHERE comlinalb.empresa =:codigo_empresa
		AND   comlinalb.anyo    =:anyo_st
		AND   comlinalb.albaran =:albaran
		AND   comlinalb.linea   =:linea_alb ;
		IF SQLCA.SQLCode <> 0 THEN
			bien = 1
			exit
		END IF
	END IF
NEXT

if bien <> 0 then 
	messagebox(string(bien)+" error/es en albarán","El proceso no se actualiza ~n~r"+sqlca.sqlerrtext)
	rollback;
else
	commit;
end if
dw_1.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text)

end event

type cb_2 from commandbutton within w_confirma_alb_jefe
integer x = 14
integer y = 564
integer width = 315
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close(w_confirma_alb_jefe)

end event

type em_anyo2 from u_em_campo within w_confirma_alb_jefe
integer x = 27
integer y = 204
integer width = 201
integer taborder = 0
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

type em_alb from u_em_campo within w_confirma_alb_jefe
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 265
integer y = 204
integer width = 219
integer taborder = 30
string facename = "Arial"
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comcabalb"
ue_titulo     =  "AYUDA SELECCION DE ALBARANES COMPRAS"
ue_filtro     =  "anyo = '"+em_anyo2.text+"'"
valor_empresa = TRUE
end event

type uo_mprima from u_em_campo_2 within w_confirma_alb_jefe
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 558
integer y = 204
integer width = 969
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_mprima.em_campo.text=f_nombre_mprima(codigo_empresa,uo_mprima.em_codigo.text)
If Trim(uo_mprima.em_campo.text)="" Then
	If Trim(uo_mprima.em_codigo.text)<>"" then uo_mprima.em_campo.SetFocus()
	uo_mprima.em_campo.text=""
	uo_mprima.em_codigo.text=""
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venmprima2"
ue_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS POR PROVEEDOR"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_mprima.destroy
call u_em_campo_2::destroy
end on

type gb_2 from groupbox within w_confirma_alb_jefe
integer x = 507
integer y = 116
integer width = 1056
integer height = 200
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Materia Prima"
end type

type st_8 from statictext within w_confirma_alb_jefe
integer x = 219
integer y = 204
integer width = 69
integer height = 76
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_confirma_alb_jefe
integer y = 116
integer width = 507
integer height = 200
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Albarán"
end type

type cb_3 from commandbutton within w_confirma_alb_jefe
integer x = 2546
integer y = 160
integer width = 315
integer height = 144
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;dw_1.setfilter(f_filtro())
dw_1.filter()
dw_1.Retrieve(codigo_empresa)


end event

type gb_6 from groupbox within w_confirma_alb_jefe
integer y = 428
integer width = 343
integer height = 236
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_1 from datawindow within w_confirma_alb_jefe
integer x = 352
integer y = 320
integer width = 2533
integer height = 960
string dataobject = "dw_confirma_alb_jefe"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if isnull(dwo) then return

long i,lineas
string pulsado

CHOOSE CASE dwo.name
	CASE "boton_bueno"
		pulsado=dwo.border
		if pulsado='6' then
			dwo.border='5'
			dw_1.Object.boton_malo.border='6'
			dw_1.object.boton_nc.border='6'
			lineas=dw_1.rowcount()
			for i=1 to lineas
				dw_1.setitem(i,"comlinalb_libre",'B')
			next
		end if
	CASE "boton_malo"
		pulsado=dwo.border
		if pulsado='6' then
			dwo.border='5'
			dw_1.Object.boton_bueno.border='6'
			dw_1.object.boton_nc.border='6'
			lineas=dw_1.rowcount()
			for i=1 to lineas
				dw_1.setitem(i,"comlinalb_libre",'M')
			next
		end if
END CHOOSE

end event

event retrieveend;long i
FOR i=1 TO rowcount
	dw_1.setitem(i,"comlinalb_libre","C")
NEXT

end event

