$PBExportHeader$w_con_consumo_mp_por_familias.srw
forward
global type w_con_consumo_mp_por_familias from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_consumo_mp_por_familias
end type
type pb_2 from upb_imprimir within w_con_consumo_mp_por_familias
end type
type cb_1 from commandbutton within w_con_consumo_mp_por_familias
end type
type gb_1 from groupbox within w_con_consumo_mp_por_familias
end type
type gb_6 from groupbox within w_con_consumo_mp_por_familias
end type
type dw_informe from datawindow within w_con_consumo_mp_por_familias
end type
type em_fdesde from u_em_campo within w_con_consumo_mp_por_familias
end type
type em_fhasta from u_em_campo within w_con_consumo_mp_por_familias
end type
type st_contador from statictext within w_con_consumo_mp_por_familias
end type
end forward

global type w_con_consumo_mp_por_familias from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 3854
integer height = 3084
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
st_contador st_contador
end type
global w_con_consumo_mp_por_familias w_con_consumo_mp_por_familias

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Date  fecha1,fecha2
string sel, anyo_ant
long actual, i, total_registros
datastore ds_datos
string familia, descripcion
dec importe, importe2

st_contador.visible = true

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()

data.setredraw(false)		
fecha1 = date(em_fdesde.text)
fecha2 = date(em_fhasta.text)

anyo_ant = string(RelativeDate(fecha2, -365))

data.reset()
data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text
/*
sel = " SELECT venmprima.familia,  venfamilias.descripcion, "+&
"  sum( CASE   "+&
"					WHEN (prodaplicaciones.coste_euros_m2 is null or prodaplicaciones.coste_euros_m2 = 0 )  "+&
"					THEN  prodformula.coste_kg_formula * art_ver_op_aplicaciones.gramaje	  "+&
"					ELSE prodaplicaciones.coste_euros_m2 * (( formatos.ancho * formatos.largo) / 10000)  "+&
"				END) as importe  "+&
"    FROM prodpartes_ot,   "+&
"         art_ver_operaciones,  "+& 
"         art_ver_op_aplicaciones, "+& 
"         prodformula,   "+&
"         proddetformula,  "+&
"         venmprima,  "+&
"         formatos,  "+&
"         prodaplicaciones,  "+&
"         comartpro, "+&
"	 	venfamilias "+&
"   WHERE prodpartes_ot.empresa = art_ver_operaciones.empresa  and  "+&
"         prodpartes_ot.articulo = art_ver_operaciones.articulo  and  "+&
"         prodpartes_ot.version = art_ver_operaciones.version  and  "+&
"         prodpartes_ot.ordenoperacion = art_ver_operaciones.orden  and "+&  
"		 art_ver_op_aplicaciones.empresa = prodaplicaciones.empresa and "+& 
"		 art_ver_op_aplicaciones.tipoaplicacion = prodaplicaciones.codigo and " +&
"	      venmprima.empresa = venfamilias.empresa and "+&
"	       venmprima.familia = venfamilias.familia and  "+&
"		 prodpartes_ot.empresa = formatos.empresa and "+&
"		 prodpartes_ot.formato = formatos.codigo and "+&
"         art_ver_operaciones.empresa = art_ver_op_aplicaciones.empresa  and  "+&
"         art_ver_operaciones.articulo = art_ver_op_aplicaciones.articulo  and  "+&
"         art_ver_operaciones.version = art_ver_op_aplicaciones.version  and  "+&
"         art_ver_operaciones.operacion = art_ver_op_aplicaciones.operacion  and "+& 
"         art_ver_op_aplicaciones.empresa = prodformula.empresa  and  "+&
"         art_ver_op_aplicaciones.formula = prodformula.formula  and  "+&
"         art_ver_op_aplicaciones.empresa = proddetformula.empresa  and  "+&
"         art_ver_op_aplicaciones.formula = proddetformula.formulacion  and "+& 
"         proddetformula.empresa = venmprima.empresa  and  "+&
"         proddetformula.mp = venmprima.codigo  and  "+&
"         proddetformula.empresa = comartpro.empresa  and  "+&
"         proddetformula.mp = comartpro.mprima  and "+&
"         proddetformula.proveedor = comartpro.proveedor  and  "+&
"         prodpartes_ot.empresa = '"+codigo_empresa+"' and "+&
"         prodpartes_ot.fecha >= '"+em_fdesde.text+"' and "+&
"         prodpartes_ot.fecha <= '"+em_fhasta.text+"' and "+&
"	       venfamilias.tipo_materia = '17' "+&
"   GROUP BY venmprima.familia,  venfamilias.descripcion"
*/				

sel = " SELECT venmprima.familia,  venfamilias.descripcion, "+&
"	 			sum( ( prodpartes_ot.buenas + prodpartes_ot.malas ) * proddetformula.coste_mp * art_ver_op_aplicaciones.gramaje ) importe "+&
"    FROM prodpartes_ot,   "+&
"         art_ver_operaciones,  "+& 
"         art_ver_op_aplicaciones, "+& 
"         prodformula,   "+&
"         proddetformula,  "+&
"         venmprima,  "+&
"         comartpro, "+&
"	 		venfamilias "+&
"   WHERE prodpartes_ot.empresa = art_ver_operaciones.empresa  and  "+&
"         prodpartes_ot.articulo = art_ver_operaciones.articulo  and  "+&
"         prodpartes_ot.version = art_ver_operaciones.version  and  "+&
"         prodpartes_ot.ordenoperacion = art_ver_operaciones.orden  and "+&  
"	       venmprima.empresa = venfamilias.empresa and "+&
"	       venmprima.familia = venfamilias.familia and "+&
"         art_ver_operaciones.empresa = art_ver_op_aplicaciones.empresa  and  "+&
"         art_ver_operaciones.articulo = art_ver_op_aplicaciones.articulo  and  "+&
"         art_ver_operaciones.version = art_ver_op_aplicaciones.version  and  "+&
"         art_ver_operaciones.operacion = art_ver_op_aplicaciones.operacion  and "+& 
"         art_ver_op_aplicaciones.empresa = prodformula.empresa  and  "+&
"         art_ver_op_aplicaciones.formula = prodformula.formula  and  "+&
"         art_ver_op_aplicaciones.empresa = proddetformula.empresa  and  "+&
"         art_ver_op_aplicaciones.formula = proddetformula.formulacion  and "+& 
"         proddetformula.empresa = venmprima.empresa  and  "+&
"         proddetformula.mp = venmprima.codigo  and  "+&
"         proddetformula.empresa = comartpro.empresa  and  "+&
"         proddetformula.mp = comartpro.mprima  and "+&
"         proddetformula.proveedor = comartpro.proveedor  and  "+&
"         prodpartes_ot.empresa = '"+codigo_empresa+"' and "+&
"         prodpartes_ot.fecha >= '"+em_fdesde.text+"' and "+&
"         prodpartes_ot.fecha <= '"+em_fhasta.text+"' and "+&
"	       venfamilias.tipo_materia = '17' "+&
"   GROUP BY venmprima.familia,  venfamilias.descripcion"


st_contador.text = " Cargando Registros. "
f_cargar_cursor_nuevo(sel, ds_datos)

total_registros = ds_datos.rowcount() 
for i = 1 to total_registros 
	familia = ds_datos.object.venmprima_familia[i]
	descripcion = ds_datos.object.venfamilias_descripcion[i]
	importe = ds_datos.object.importe[i]
//	importe2 = ds_datos.object.importe2[i]
	
	actual = data.insertrow(0)

	data.object.familia[actual] = familia
	data.object.descripcion[actual] = descripcion
	data.object.importe[actual] = importe
//	data.object.importe2[actual] = importe2

	st_contador.text = "Registro: "+string(i, "###,###,###,###,##0")+" de "+string(total_registros, "###,###,###,###,##0")
next

destroy ds_datos

st_contador.visible = false
data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe Consumo de Materias Primas por Familia "
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-09-01"
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_con_consumo_mp_por_familias.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_contador=create st_contador
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.st_contador
end on

on w_con_consumo_mp_por_familias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_contador)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_consumo_mp_por_familias
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_consumo_mp_por_familias
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_consumo_mp_por_familias
integer y = 8
integer width = 3616
integer height = 92
end type

type pb_1 from upb_salir within w_con_consumo_mp_por_familias
integer x = 3639
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_consumo_mp_por_familias
integer x = 3602
integer y = 148
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_consumo_mp_por_familias
integer x = 3305
integer y = 148
integer width = 288
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_con_consumo_mp_por_familias
integer x = 82
integer y = 104
integer width = 617
integer height = 160
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type gb_6 from groupbox within w_con_consumo_mp_por_familias
integer x = 3287
integer y = 108
integer width = 462
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within w_con_consumo_mp_por_familias
integer x = 91
integer y = 288
integer width = 3639
integer height = 2508
boolean bringtotop = true
string dataobject = "dw_con_consumo_mp_por_familias"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type em_fdesde from u_em_campo within w_con_consumo_mp_por_familias
integer x = 96
integer y = 164
integer width = 288
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_consumo_mp_por_familias
integer x = 393
integer y = 164
integer width = 288
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_contador from statictext within w_con_consumo_mp_por_familias
boolean visible = false
integer x = 1257
integer y = 180
integer width = 1047
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

