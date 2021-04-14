$PBExportHeader$w_int_movtraspasos.srw
$PBExportComments$Proceso introduccion de traspasos entre ubicaciones.
forward
global type w_int_movtraspasos from w_int_con_empresa
end type
type st_11 from statictext within w_int_movtraspasos
end type
type st_texto_cantidad from statictext within w_int_movtraspasos
end type
type st_4 from statictext within w_int_movtraspasos
end type
type st_3 from statictext within w_int_movtraspasos
end type
type st_2 from statictext within w_int_movtraspasos
end type
type st_1 from statictext within w_int_movtraspasos
end type
type st_9 from statictext within w_int_movtraspasos
end type
type pb_1 from upb_salir within w_int_movtraspasos
end type
type dw_2 from datawindow within w_int_movtraspasos
end type
type em_fecha from u_em_campo within w_int_movtraspasos
end type
type em_tono from u_em_campo within w_int_movtraspasos
end type
type em_calibre from u_em_campo within w_int_movtraspasos
end type
type em_cantidad from u_em_campo within w_int_movtraspasos
end type
type sle_observaciones from u_em_campo within w_int_movtraspasos
end type
type cb_1 from u_boton within w_int_movtraspasos
end type
type cb_borrar from u_boton within w_int_movtraspasos
end type
type dw_proceso from datawindow within w_int_movtraspasos
end type
type cb_4 from u_boton within w_int_movtraspasos
end type
type cb_3 from u_boton within w_int_movtraspasos
end type
type uo_articulo from u_em_campo_2 within w_int_movtraspasos
end type
type uo_calidad from u_em_campo_2 within w_int_movtraspasos
end type
type st_texto_cajas from statictext within w_int_movtraspasos
end type
type st_texto_palets from statictext within w_int_movtraspasos
end type
type em_cajas from u_em_campo within w_int_movtraspasos
end type
type em_palets from u_em_campo within w_int_movtraspasos
end type
type dw_detalle from datawindow within w_int_movtraspasos
end type
type cb_2 from u_boton within w_int_movtraspasos
end type
type dw_listado from datawindow within w_int_movtraspasos
end type
type pb_listado from upb_imprimir within w_int_movtraspasos
end type
type st_listado from statictext within w_int_movtraspasos
end type
type dw_pedidos from datawindow within w_int_movtraspasos
end type
type dw_ordenes from datawindow within w_int_movtraspasos
end type
type dw_proceso1 from datawindow within w_int_movtraspasos
end type
type dw_proceso2 from datawindow within w_int_movtraspasos
end type
type st_formato from statictext within w_int_movtraspasos
end type
type dw_tipos_caja from datawindow within w_int_movtraspasos
end type
type gb_1 from groupbox within w_int_movtraspasos
end type
type dw_5 from datawindow within w_int_movtraspasos
end type
type st_14 from statictext within w_int_movtraspasos
end type
type dw_1 from u_datawindow_consultas within w_int_movtraspasos
end type
type dw_3 from datawindow within w_int_movtraspasos
end type
type st_6 from statictext within w_int_movtraspasos
end type
end forward

global type w_int_movtraspasos from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 4933
integer height = 3256
st_11 st_11
st_texto_cantidad st_texto_cantidad
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_9 st_9
pb_1 pb_1
dw_2 dw_2
em_fecha em_fecha
em_tono em_tono
em_calibre em_calibre
em_cantidad em_cantidad
sle_observaciones sle_observaciones
cb_1 cb_1
cb_borrar cb_borrar
dw_proceso dw_proceso
cb_4 cb_4
cb_3 cb_3
uo_articulo uo_articulo
uo_calidad uo_calidad
st_texto_cajas st_texto_cajas
st_texto_palets st_texto_palets
em_cajas em_cajas
em_palets em_palets
dw_detalle dw_detalle
cb_2 cb_2
dw_listado dw_listado
pb_listado pb_listado
st_listado st_listado
dw_pedidos dw_pedidos
dw_ordenes dw_ordenes
dw_proceso1 dw_proceso1
dw_proceso2 dw_proceso2
st_formato st_formato
dw_tipos_caja dw_tipos_caja
gb_1 gb_1
dw_5 dw_5
st_14 st_14
dw_1 dw_1
dw_3 dw_3
st_6 st_6
end type
global w_int_movtraspasos w_int_movtraspasos

type variables
//str_parametros  istr_parametros
  integer contador,v_fila,v_altura,anyo
  string v_almacen,v_zona,v_familia,v_sector,v_caja
  decimal{4} v_cantidad,disp_int
  string ante_codigo_articulo,ante_codigo_calidad,ante_tono

Boolean  control_tono,control_calibre

// Defino la estructura de la tablas a procesar
   str_almlinubicahis  ubihis
   str_almlinubica      ubi
   str_almmovhis        movhis
   


end variables

forward prototypes
public subroutine f_control_ubicacion ()
public subroutine f_control_tono_calibre ()
public subroutine f_listado_incidencias (string empresa, string articulo, string calidad, string tono, integer calibre, string tipo_pallet, string caja)
end prototypes

public subroutine f_control_ubicacion ();decimal{2} var_cantidad,total_cantidad,cur_existencias
string  var_referencia,var_ubicacion
String  cur_empresa
Integer cur_pedido,cur_linea,salir
String  cur_ubicacion,cur_referencia,cur_tipo_pallet,cur_caja

string tipo_pal,caja
tipo_pal = dw_2.GetItemString(dw_2.Getrow(),"tipo_pallet")
caja     = dw_2.GetItemString(dw_2.Getrow(),"caja")

total_cantidad=0

var_ubicacion=f_componer_ubicacion(dw_2.GetItemString(dw_2.GetRow(),"almacen"),&
                                   dw_2.GetItemString(dw_2.GetRow(),"zona"),&
                                   dw_2.GetItemNumber(dw_2.GetRow(),"fila"),&
                                   dw_2.GetItemNumber(dw_2.GetRow(),"altura"))


var_referencia=f_componer_ref(uo_articulo.em_codigo.text,&
                              uo_calidad.em_codigo.text,&
                              Trim(em_tono.text),&
                              Integer(em_calibre.text))

Integer registros,x1

registros = dw_proceso.retrieve(codigo_empresa,var_ubicacion,var_referencia,caja)

IF registros<>0 THEN
  For x1 = 1 To registros
    
      cur_pedido      =  dw_proceso.GetItemNumber(x1,"pedido")       
      cur_linea       =  dw_proceso.GetItemNumber(x1,"linea")
      cur_existencias =  dw_proceso.GetItemNumber(x1,"existencias")
      cur_tipo_pallet =  dw_proceso.GetItemString(x1,"tipo_pallet")
		cur_caja        =  dw_proceso.GetItemString(x1,"caja")

      IF IsNull(cur_pedido) or trim(string(cur_pedido))="" or cur_tipo_pallet=tipo_pal and cur_caja=caja THEN
         total_cantidad=cur_existencias + total_cantidad
      END IF
  NEXT
End If

//*** Prueba Mila
//IF Dec(em_cantidad.text) > total_cantidad THEN
//     em_cantidad.text=String(total_cantidad)
//END IF

end subroutine

public subroutine f_control_tono_calibre (); control_tono    =  TRUE
 control_calibre =  TRUE

 IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_tono   =  FALSE
 	em_tono.text       =  ""
END IF
IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_calibre =  FALSE
   em_calibre.text    =  "0"
 END IF  

end subroutine

public subroutine f_listado_incidencias (string empresa, string articulo, string calidad, string tono, integer calibre, string tipo_pallet, string caja);IF IsNull(disp_int) Then disp_int = 0
IF disp_int >=0 Then Return
Integer re,re1,cont,j
String cliente,var_ubicaciones,var_referencia,situacion
Dec{0}  pedido,orden,linea
Dec cantidad
DateTime  fpedido,forden
var_referencia  = f_componer_ref(articulo,calidad,tono,calibre)
cont = 0
re1 = dw_pedidos.Retrieve(empresa,articulo,calidad,tono,calibre,tipo_pallet,caja)
IF re1 <> 0 Then
	For re =1 To re1
		cont    = cont +1
		fpedido = dw_pedidos.GetItemDateTime(re,"fpedido")
		pedido  = dw_pedidos.GetItemNumber(re,"pedido")
		anyo    = dw_pedidos.GetItemNumber(re,"anyo")
		linea   = dw_pedidos.GetItemNumber(re,"linea")
		cantidad = dw_pedidos.GetItemNumber(re,"cantidad")
		cliente = dw_pedidos.GetItemString(re,"cliente")
		IF  dw_pedidos.GetItemString(re,"situacion") <> "P" Then
			 var_ubicaciones= f_ubicaciones_referencia_tipo_pallet(codigo_empresa,var_referencia,tipo_pallet,2,"S")
		ELSE
			var_ubicaciones= f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,tipo_pallet,anyo,pedido,linea)
		END IF
		dw_listado.InsertRow(cont)
		dw_listado.SetItem(cont,"empresa",empresa)
		dw_listado.SetItem(cont,"articulo",articulo)
		dw_listado.SetItem(cont,"calidad",calidad)
		dw_listado.SetItem(cont,"tono",tono)
		dw_listado.SetItem(cont,"calibre",calibre)
		dw_listado.SetItem(cont,"tipo_pallet",tipo_pallet)
		dw_listado.SetItem(cont,"caja",caja)
		dw_listado.SetItem(cont,"cliente",cliente)
		dw_listado.SetItem(cont,"pedido",pedido)
		dw_listado.SetItem(cont,"cantidad",cantidad)
		dw_listado.SetItem(cont,"fpedido",fpedido)
		dw_listado.SetItem(cont,"ubicacion",var_ubicaciones)
	Next
END IF


re1 = dw_ordenes.Retrieve(empresa,articulo,calidad,tono,calibre,tipo_pallet,caja)
IF re1 <> 0 Then
	For re =1 To re1
		cont = cont +1
		fpedido = dw_ordenes.GetItemDateTime(re,"fecha_ped")
		cliente = dw_ordenes.GetItemstring(re,"cliente")
		orden = dw_ordenes.GetItemNumber(re,"orden")
		forden = dw_ordenes.GetItemDateTime(re,"forden")
		pedido = dw_ordenes.GetItemNumber(re,"pedido")
		anyo = dw_ordenes.GetItemNumber(re,"anyo_ped")
		linea = dw_ordenes.GetItemNumber(re,"linea_ped")
		cantidad = dw_ordenes.GetItemNumber(re,"cantidad")
		IF dw_ordenes.GetItemString(re,"situacion_pedido")<>"P" Then
			 var_ubicaciones= f_ubicaciones_referencia_tipo_pallet(codigo_empresa,var_referencia,tipo_pallet,2,"S")
		ELSE
			var_ubicaciones= f_ubicaciones_referencia_preparado(codigo_empresa,var_referencia,tipo_pallet,anyo,pedido,linea)
		END IF
		dw_listado.InsertRow(cont)
		dw_listado.SetItem(cont,"empresa",empresa)
		dw_listado.SetItem(cont,"articulo",articulo)
		dw_listado.SetItem(cont,"calidad",calidad)
		dw_listado.SetItem(cont,"tono",tono)
		dw_listado.SetItem(cont,"calibre",calibre)
		dw_listado.SetItem(cont,"tipo_pallet",tipo_pallet)
		dw_listado.SetItem(cont,"caja",caja)
		dw_listado.SetItem(cont,"pedido",pedido)
		dw_listado.SetItem(cont,"cantidad",cantidad)
		dw_listado.SetItem(cont,"fpedido",fpedido)
		dw_listado.SetItem(cont,"orden",orden)
		dw_listado.SetItem(cont,"forden",forden)
		dw_listado.SetItem(cont,"cliente",cliente)
		dw_listado.SetItem(cont,"ubicacion",var_ubicaciones)
	Next
END IF
IF dw_listado.RowCount()<> 0 Then
	
	pb_listado.visible = TRUE
	st_listado.visible = TRUE
END IF
end subroutine

event open;call super::open;
istr_parametros.s_titulo_ventana="Introduccion Movimientos traspasos almacen"
This.title=istr_parametros.s_titulo_ventana
dw_1.visible=false
em_fecha.text=String(today())
dw_listado.SetTransObject(SQLCA)
dw_proceso1.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
// preparo datawindow ubicaciones
dw_2.settransobject(SQLCA)
//dw_2.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator


dw_3.SetTransObject(SQLCA)
dw_5.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
datetime fecha
fecha = Datetime(Date(em_fecha.text))
dw_3.retrieve(codigo_empresa,fecha)

dw_pedidos.SetTransObject(SQLCA)
dw_ordenes.SetTransObject(SQLCA)
dw_tipos_caja.SetTransObject(SQLCA)
f_activar_campo(uo_articulo.em_campo)
end event

on w_int_movtraspasos.create
int iCurrent
call super::create
this.st_11=create st_11
this.st_texto_cantidad=create st_texto_cantidad
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_9=create st_9
this.pb_1=create pb_1
this.dw_2=create dw_2
this.em_fecha=create em_fecha
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.em_cantidad=create em_cantidad
this.sle_observaciones=create sle_observaciones
this.cb_1=create cb_1
this.cb_borrar=create cb_borrar
this.dw_proceso=create dw_proceso
this.cb_4=create cb_4
this.cb_3=create cb_3
this.uo_articulo=create uo_articulo
this.uo_calidad=create uo_calidad
this.st_texto_cajas=create st_texto_cajas
this.st_texto_palets=create st_texto_palets
this.em_cajas=create em_cajas
this.em_palets=create em_palets
this.dw_detalle=create dw_detalle
this.cb_2=create cb_2
this.dw_listado=create dw_listado
this.pb_listado=create pb_listado
this.st_listado=create st_listado
this.dw_pedidos=create dw_pedidos
this.dw_ordenes=create dw_ordenes
this.dw_proceso1=create dw_proceso1
this.dw_proceso2=create dw_proceso2
this.st_formato=create st_formato
this.dw_tipos_caja=create dw_tipos_caja
this.gb_1=create gb_1
this.dw_5=create dw_5
this.st_14=create st_14
this.dw_1=create dw_1
this.dw_3=create dw_3
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_11
this.Control[iCurrent+2]=this.st_texto_cantidad
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_9
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.em_fecha
this.Control[iCurrent+11]=this.em_tono
this.Control[iCurrent+12]=this.em_calibre
this.Control[iCurrent+13]=this.em_cantidad
this.Control[iCurrent+14]=this.sle_observaciones
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.cb_borrar
this.Control[iCurrent+17]=this.dw_proceso
this.Control[iCurrent+18]=this.cb_4
this.Control[iCurrent+19]=this.cb_3
this.Control[iCurrent+20]=this.uo_articulo
this.Control[iCurrent+21]=this.uo_calidad
this.Control[iCurrent+22]=this.st_texto_cajas
this.Control[iCurrent+23]=this.st_texto_palets
this.Control[iCurrent+24]=this.em_cajas
this.Control[iCurrent+25]=this.em_palets
this.Control[iCurrent+26]=this.dw_detalle
this.Control[iCurrent+27]=this.cb_2
this.Control[iCurrent+28]=this.dw_listado
this.Control[iCurrent+29]=this.pb_listado
this.Control[iCurrent+30]=this.st_listado
this.Control[iCurrent+31]=this.dw_pedidos
this.Control[iCurrent+32]=this.dw_ordenes
this.Control[iCurrent+33]=this.dw_proceso1
this.Control[iCurrent+34]=this.dw_proceso2
this.Control[iCurrent+35]=this.st_formato
this.Control[iCurrent+36]=this.dw_tipos_caja
this.Control[iCurrent+37]=this.gb_1
this.Control[iCurrent+38]=this.dw_5
this.Control[iCurrent+39]=this.st_14
this.Control[iCurrent+40]=this.dw_1
this.Control[iCurrent+41]=this.dw_3
this.Control[iCurrent+42]=this.st_6
end on

on w_int_movtraspasos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_11)
destroy(this.st_texto_cantidad)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_9)
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.em_fecha)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.em_cantidad)
destroy(this.sle_observaciones)
destroy(this.cb_1)
destroy(this.cb_borrar)
destroy(this.dw_proceso)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.uo_articulo)
destroy(this.uo_calidad)
destroy(this.st_texto_cajas)
destroy(this.st_texto_palets)
destroy(this.em_cajas)
destroy(this.em_palets)
destroy(this.dw_detalle)
destroy(this.cb_2)
destroy(this.dw_listado)
destroy(this.pb_listado)
destroy(this.st_listado)
destroy(this.dw_pedidos)
destroy(this.dw_ordenes)
destroy(this.dw_proceso1)
destroy(this.dw_proceso2)
destroy(this.st_formato)
destroy(this.dw_tipos_caja)
destroy(this.gb_1)
destroy(this.dw_5)
destroy(this.st_14)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.st_6)
end on

event activate;call super::activate;w_int_movtraspasos = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_movtraspasos
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_movtraspasos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_movtraspasos
integer x = 18
integer width = 4645
integer height = 80
end type

type st_11 from statictext within w_int_movtraspasos
integer x = 14
integer y = 168
integer width = 206
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_movtraspasos
integer x = 4507
integer y = 276
integer width = 297
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_movtraspasos
integer x = 1138
integer y = 276
integer width = 73
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_movtraspasos
integer x = 1019
integer y = 276
integer width = 114
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_movtraspasos
integer x = 873
integer y = 276
integer width = 142
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_int_movtraspasos
integer x = 9
integer y = 276
integer width = 480
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_movtraspasos
integer x = 59
integer y = 1392
integer width = 439
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Observaciones"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_movtraspasos
integer x = 4690
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
alignment htextalign = right!
end type

event clicked;IF dw_listado.RowCOunt() <> 0 Then
	f_mensaje("No se puede salir","Listar Incidencias")
	Return
END IF
Call Super::Clicked
end event

type dw_2 from datawindow within w_int_movtraspasos
event key pbm_dwnkey
integer x = 1216
integer y = 272
integer width = 2930
integer height = 1096
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_int_movtraspasos1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;IF this.getRow()<>0 THEN
 integer registros
 long linea
 linea     = dw_2.GetRow() 
 
 IF linea<>0 THEN
    registros = dw_2.RowCount()
//    IF registros>0 THEN
//      em_cantidad.text=String(GetItemNumber(GetRow(),"existencias"))
//		  em_palets.text= ""
//      em_cajas.text = ""    
//    End If
    This.SelectRow(0,FALSE)
    This.SelectRow(getRow(),TRUE)
  
      uo_calidad.em_codigo.text =  GetItemString(dw_2.getRow(),"calidad")
      em_tono.text              =  String(GetItemString(dw_2.getRow(),"tonochar"))
      em_calibre.text           =  String(GetItemNumber(dw_2.getRow(),"calibre"))
      sle_observaciones.text    =  GetItemString(dw_2.GetRow(),"observaciones")
		uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
  End If
End IF
 


end event

on getfocus;
This.TriggerEvent(RowFocusChanged!)

end on

type em_fecha from u_em_campo within w_int_movtraspasos
integer x = 256
integer y = 168
integer width = 352
integer taborder = 40
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

on modified;call u_em_campo::modified;dw_3.retrieve(codigo_empresa,datetime(date(em_fecha.text)))
end on

type em_tono from u_em_campo within w_int_movtraspasos
integer x = 1024
integer y = 356
integer width = 105
integer height = 76
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
boolean border = false
alignment alignment = center!
borderstyle borderstyle = stylebox!
string mask = "!!!!"
end type

event modificado;call super::modificado;// Visualiza las lineas de ubicación a nivel de articulo-calidad-tono

if ante_tono<>em_tono.text then
   if trim(em_tono.text)<>"" THEN
      STRING is_filtro = ""
      if trim(uo_articulo.em_codigo.text)<>"" then

      is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"	
      is_filtro = is_filtro + " AND tono = " + em_tono.text  
  
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()
      dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
    End If

  End If
End if
f_control_tono_calibre()
end event

on getfocus;call u_em_campo::getfocus;ante_tono = em_tono.text
end on

type em_calibre from u_em_campo within w_int_movtraspasos
integer x = 1138
integer y = 352
integer width = 73
integer height = 80
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
boolean border = false
alignment alignment = center!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "0"
end type

event modificado;call super::modificado;f_control_tono_calibre()
end event

type em_cantidad from u_em_campo within w_int_movtraspasos
integer x = 4507
integer y = 356
integer width = 293
integer height = 80
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
boolean border = false
alignment alignment = right!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;string cadena
long posi,posi_aux

em_palets.text= ""
em_cajas.text = ""

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
                          dw_2.GetItemString(dw_2.getRow(),"caja"),&
								  integer(em_palets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_palets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if





end event

type sle_observaciones from u_em_campo within w_int_movtraspasos
integer x = 521
integer y = 1388
integer width = 4242
integer taborder = 180
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type cb_1 from u_boton within w_int_movtraspasos
integer x = 4562
integer y = 468
integer width = 238
integer height = 128
integer taborder = 200
string text = "&Ok"
end type

event clicked;f_control_tono_calibre()

//CONTROLES DE VALORES

Dec{2} total_cantidad,var_conjunto
String cadena
long posi,posi_aux
Date ahora, fecha
Long respuesta

dw_1.reset()
IF dw_2.GetRow()=0 then 	return

total_cantidad   = dw_2.GetItemNumber(dw_2.GetRow(),"existencias")

if dec(em_cantidad.text) > total_cantidad then
	MessageBox("Error", "No puede traspasar más artículos de los que hay")
	return
end if

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
								  dw_2.GetItemString(dw_2.getRow(),"caja"),&
                          0,&
                          0,Dec(em_cantidad.text))
                      
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_palets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if





//IF dec(em_cantidad.text)>total_cantidad THEN
//   f_activar_campo(em_cantidad)
//   MessageBox("No Puedo Procesar","Cantidad en ubicacion menor",exclamation!, OK!,1)
//   Return
//END IF

string mensaje

IF trim(em_fecha.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF

ahora = Date(Today())
fecha = Date(em_fecha.text)

if ahora <> fecha then
	respuesta = MessageBox("Atención Fecha","La fecha indicada ("+em_fecha.text+") no coincide con la actual ("+String(ahora)+"). Aun así, ¿desea continuar?",Question!, YesNo!,2)
	if respuesta = 2 then
	   em_fecha.SetFocus()
		return
	end if
end if

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF

IF v_sector = "S" THEN
  IF trim(uo_calidad.em_campo.text)="" THEN
   mensaje="Introduzca la calidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   uo_calidad.Setfocus()
   RETURN
  END IF
  IF control_tono=TRUE Then
		  IF trim(em_tono.text)="" THEN
				mensaje="Introduzca el tono"
				MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
				em_tono.SetFocus()
				RETURN
		  END IF
  END IF
  IF control_calibre=TRUE Then
		  IF trim(em_calibre.text)="" THEN
				mensaje="Introduzca el calibre"
				MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
				em_calibre.SetFocus()
				RETURN
        END IF
  END IF
END IF

IF dw_2.GetRow() =0  THEN
   mensaje="Marcar Una Ubicacion"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   dw_2.SetFocus()
   RETURN
END IF

IF v_sector = "S" THEN
   string codigo_articulo
   String codigo_calidad
   codigo_articulo=uo_articulo.em_codigo.text
   codigo_calidad= uo_calidad.em_codigo.text
   SELECT almartcal.calidad  INTO :codigo_calidad  
    FROM almartcal  
   WHERE (almartcal.empresa   = :codigo_empresa ) AND  
         (almartcal.articulo  = :codigo_articulo ) AND  
         (almartcal.calidad   = :codigo_calidad ) USING SQLCA;
   IF SQLCA.SQLCode<>0 THEN
   MessageBox("Calidad no válida","Esta calidad no está definida para el artículo",Exclamation!, OK!,1)
     uo_calidad.em_campo.text    = ""
     uo_calidad.em_codigo.text = ""
     uo_calidad.em_campo.Setfocus()
     Return
   END IF
END IF


// controlo las existencias disponibles
f_control_ubicacion()



IF Dec(em_cantidad.text)=0 or trim(em_cantidad.text)="" THEN
   mensaje="Introduzca nº total de cantidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

var_conjunto= f_conjunto_articulo(codigo_empresa,uo_articulo.em_codigo.text)
// Control piezas por conjunto
IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
 IF (Dec(String(Dec(em_cantidad.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad.text) Then
  MessageBox("Cantidad no valida","Esta artículo va por conjuntos la cantidad ha de ser múltiplo de: " + String(var_conjunto),Exclamation!, OK!,1)
  f_activar_campo(em_cantidad)
  return
 END IF
END IF



dw_1.visible      = TRUE
//cb_2.visible      = TRUE //Ángel - 22/07/2013
cb_3.visible      = TRUE
cb_4.visible      = TRUE
//cb_borrar.visible = TRUE //Ángel - 22/07/2013

dw_1.retrieve()
contador=dw_1.Rowcount()
contador=contador+1

dw_1.insertRow(contador)

dw_1.setitem(Contador,"cantidad",dec(em_cantidad.text))
dw_1.setitem(contador,"empresa",codigo_empresa)
dw_1.setitem(contador,"tipo_unidad",f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
dw_1.setitem(contador,"tonochar",em_tono.text)
dw_1.setitem(contador,"calibre",em_calibre.text)
dw_1.setitem(contador,"articulo",uo_articulo.em_codigo.text)
dw_1.setitem(contador,"calidad",uo_calidad.em_codigo.text)

//Ángel - 22/07/2013
dw_1.setitem(Contador,"caja",String(dw_2.object.caja[dw_2.getrow()]))
dw_1.setitem(Contador,"tipo_pallet", String(dw_2.object.tipo_pallet[dw_2.getrow()]))

//Fin Ángel - 22/07/2013

dw_1.SetFocus()
cb_1.enabled              = FALSE
// desactivar claves

em_fecha.enabled          = FALSE
uo_articulo.enabled       = FALSE
uo_calidad.enabled        = FALSE
em_tono.enabled           = FALSE
em_calibre.enabled        = FALSE
em_cajas.enabled          = FALSE
em_cantidad.enabled       = FALSE
em_palets.enabled         = FALSE
sle_observaciones.enabled = FALSE
dw_3.visible              = FALSE
dw_2.enabled              = FALSE
disp_int = f_disponible_referencia_tipo_pallet_caja(codigo_empresa,dw_2.GetItemString(dw_2.getRow(),"referencia"),dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),dw_2.GetItemString(dw_2.getRow(),"caja")) 

end event

type cb_borrar from u_boton within w_int_movtraspasos
boolean visible = false
integer x = 1550
integer y = 2208
integer width = 475
integer height = 84
integer taborder = 210
boolean bringtotop = true
string text = "&Borrar"
end type

on clicked;call u_boton::clicked;integer fila
fila=dw_1.getrow()
IF contador=fila THEN
  IF contador<>1 THEN  contador=contador - 1
END IF
IF fila<>0 THEN
 dw_1.DeleteRow(dw_1.getRow())
 dw_1.setrowfocusIndicator(Hand!)
 dw_1.SetColumn("almacen")
 dw_1.setRow(contador)
 dw_1.setfocus()
END IF


end on

type dw_proceso from datawindow within w_int_movtraspasos
boolean visible = false
integer width = 658
integer height = 164
integer taborder = 150
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica"
boolean livescroll = true
end type

type cb_4 from u_boton within w_int_movtraspasos
boolean visible = false
integer x = 2501
integer y = 2208
integer width = 475
integer height = 84
integer taborder = 240
boolean bringtotop = true
string text = "&Procesar"
end type

event clicked;// Contador de movimiento y orden de lineas de ubicacion
   dec contador_nummov,contador_orden 
// Valor de controles funcionamiento
   dec bien=0
dec{2} numero,controles,x2,total_cantidad
string mensaje,nombre,campo,otro,v_tono,v_calibre,v_pallet,v_calidad
dec y2,longitudes
long x21
IF Trim(sle_observaciones.text) = "" Then SetNull(sle_observaciones.text)
IF len(sle_observaciones.text)<>30 and  len(sle_observaciones.text)<>0 THEN
  longitudes=len(Trim(sle_observaciones.text))
  y2=(30-longitudes)-1
  sle_observaciones.text=Trim(sle_observaciones.text) +  Space(y2) +"-"
END IF

controles  = 0
contador = dw_1.Rowcount()
IF contador=0 THEN
 MessageBox("No Puedo Procesar","No hay lineas de Ubicación",Exclamation!, OK!,1)
 Return
END IF
 dw_1.Accepttext()

FOR x2=1 TO contador
 v_almacen    = dw_1.GetItemString(x2,"almacen")	
 v_zona       = dw_1.GetItemString(x2,"zona")	
 v_fila       = dw_1.GetItemNumber(x2,"fila")	
 v_altura     = dw_1.GetItemNumber(x2,"altura")	
 v_caja       = dw_1.GetItemString(x2,"caja")
 v_tono       = dw_1.GetItemString(x2,"tonochar")
 v_calibre    = dw_1.GetItemString(x2,"calibre")
 v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
 v_pallet 	  = dw_1.GetItemString (x2,"tipo_pallet")
 v_calidad    = dw_1.GetItemString (x2,"calidad")
 dw_1.SetItem(x2,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,dw_2.GetItemString(dw_2.GetRow(),"caja"),v_cantidad))
 v_cantidad   = dw_1.GetItemDecimal(x2,"cantidad")	
 
// Control de campos obligatorios
IF (trim(string(v_almacen))="" or IsNull(v_almacen)) and controles=0 THEN
 controles=1
 campo="almacen"
 mensaje=" Introduzca el Almacén "
END IF
IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
 controles=1
 campo="zona"
 mensaje=" Introduzca la zona "
END IF
IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
 controles=1
 campo="fila"
 mensaje= "Introduzca la fila de la ubicación"
END IF
IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
 controles=1
 campo="altura"
 mensaje= "Introduzca la altura de la ubicación"
END IF
IF (trim(string(v_caja))=""  or IsNull(v_caja)) and controles=0 THEN
 controles=1
 campo="caja"
 mensaje= "Introduzca la caja"
END IF
IF (trim(string(v_pallet))=""  or IsNull(v_pallet)) and controles=0 THEN
 controles=1
 campo="tipo_pallet"
 mensaje= "Introduzca el tipo de pallet"
END IF
if control_tono then
	IF (trim(string(v_tono))=""  or IsNull(v_tono)) and controles=0 THEN
	 controles=1
	 campo="tono"
	 mensaje= "Introduzca el tono"
	END IF
end if
if control_calibre then
	IF (trim(string(v_calibre))=""  or IsNull(v_calibre)) and controles=0 THEN
	 controles=1
	 campo="calibre"
	 mensaje= "Introduzca el calibre"
	END IF
end if
IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
 controles=1
 campo="cantidad"
 mensaje= "Introduzca la cantidad"
END IF

IF (trim(v_calidad)=""  or IsNull(v_calidad)) and controles=0 THEN
 controles=1
 campo="calidad"
 mensaje= "Introduzca la calidad"
end if

nombre=f_nombre_almacen(codigo_empresa,v_almacen)
IF (trim(nombre)="") and controles=0 THEN
  mensaje="El almacén no existe "
  controles=1
  campo="almacen"
END IF

nombre=f_nombre_zona(codigo_empresa,v_almacen,v_zona)
IF (trim(nombre)="") and controles=0 THEN
   mensaje="La zona no existe"
   controles=1
   campo="zona"
END IF
 IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    mensaje= "La ubicación no está contemplada en el mapa de ubicaciones"
    controles=1
    campo="almacen"
 END IF

IF controles=1 THEN
  MessageBox("Campo obligatorio en línea"+string(x2),mensaje,Exclamation!, OK!,1)
  dw_1.SetColumn(campo)
  dw_1.setRow(x2)
  dw_1.setfocus()
 Return
END IF
NEXT


total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
IF total_cantidad<>dec(em_cantidad.text) THEN
  MessageBox("No Puedo Procesar",String(total_cantidad)+ " " + String(dw_1.GetItemNumber(1,"total_cantidad"))+ " El total de unidades/metros no coinciden",Exclamation!, OK!,1)
  dw_1.SetColumn("cantidad")
  dw_1.setRow(x2)
  dw_1.setfocus()
  Return
END IF
pb_1.enabled=FALSE


IF Not f_bloquear_almacen(w_int_movtraspasos.title) Then
//---------------------------------------------------------------------
// Despues de todos los controles empezamos el proceso de inserción
//---------------------------------------------------------------------

//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------

 ubihis.usuario       = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = year(date(String(em_fecha.text)))
 ubihis.almacen       = dw_2.GetItemString(dw_2.GetRow(),"almacen")
 ubihis.articulo      = uo_articulo.em_codigo.text
 ubihis.calidad       = uo_calidad.em_codigo.text
 ubihis.tonochar      = Trim(em_tono.text) 	//tono de la salida
 ubihis.calibre       = dec(em_calibre.text) //calibre de la salida
 ubihis.fecha         = DateTime(Date(String(em_fecha.text)))
 ubihis.f_alta        = DateTime(today(),now())
 ubihis.observaciones = sle_observaciones.text
 ubihis.tipo_pallet   = dw_2.GetItemString(dw_2.Getrow(),"tipo_pallet")
 ubihis.caja          = dw_2.GetItemString(dw_2.Getrow(),"caja")
 ubihis.sector        = v_sector
 SetNull(ubihis.nummov)


  SELECT	articulos.familia,   
			articulos.subfamilia,   
         articulos.formato,
			articulos.subformato,
			articulos.modelo,
			articulos.unidad  
    INTO	:ubihis.familia,
			:ubihis.subfamilia,
			:ubihis.formato,
			:ubihis.subformato,   
         :ubihis.modelo,
			:ubihis.tipo_unidad  
    FROM articulos  
   WHERE (articulos.empresa = :ubihis.empresa )
	AND   (articulos.codigo = :ubihis.articulo );
	
IF SQLCA.SQLCode<>0 THEN bien=1
if bien=1 then f_mensaje("Debug","1 "+ubihis.empresa + " "+ubihis.articulo)
ubihis.referencia   = f_componer_ref(ubihis.articulo,&
                                     ubihis.calidad,&
												 ubihis.tonochar,&
                                     ubihis.calibre)
ubihis.tipomov  = "102"
ubi.empresa     = ubihis.empresa
ubi.almacen     = ubihis.almacen
ubi.articulo    = ubihis.articulo
ubi.familia     = ubihis.familia
ubi.subfamilia  = ubihis.subfamilia
ubi.formato     = ubihis.formato
ubi.subformato  = ubihis.subformato
ubi.modelo      = ubihis.modelo
ubi.calidad     = ubihis.calidad
ubi.tonochar    = ubihis.tonochar
ubi.calibre     = ubihis.calibre
ubi.tipo_pallet = ubihis.tipo_pallet
ubi.caja        = ubihis.caja
ubi.sector      = ubihis.sector
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad =  ubihis.tipo_unidad
ubi.referencia  =  ubihis.referencia
ubi.f_alta      =  DateTime(today(),now())
ubihis.zona     = dw_2.GetItemString(dw_2.GetRow(),"zona")
ubihis.fila     = dw_2.GetItemNumber(dw_2.GetRow(),"fila")
ubihis.altura   = dw_2.GetItemNumber(dw_2.GetRow(),"altura")
ubihis.cantidads = Dec(em_cantidad.text)
ubihis.cantidade = 0

ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                                              ubihis.fila,ubihis.altura)
ubi.zona            = ubihis.zona
ubi.fila            = ubihis.fila
ubi.altura          = ubihis.altura
ubi.existencias     = ubihis.cantidade
ubi.ubicacion       = ubihis.ubicacion
//-------------------------------------------------------------------

    ubihis.orden   = f_almparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))


    // Variables para cargar el cursor
     dec cur_empresa,cur_almacen,cur_pedido,cur_linea,cur_anyo,&
				cur_calibre
      decimal{2}  cur_existencias,cantidad_pendiente,cantidad_borrada
      string  cur_referencia,cur_ubicacion,cur_observaciones,&
				var_observaciones,cur_tipo_pallet,cur_caja,cur_tono,cur_calidad


//-----------------------------------------------------------------------
// Tambien Inserto en el Historico de Movimientos ( la Salida Global)
//-----------------------------------------------------------------------
 movhis.empresa      =  ubihis.empresa  
 movhis.almacen      =  ubihis.almacen
 movhis.anyo         =  ubihis.anyo
 movhis.origen       =  "3"
 movhis.articulo     =  ubihis.articulo
 movhis.fechmov      =  ubihis.fecha
 movhis.tipomov      =  ubihis.tipomov
 movhis.cantidade    =  0
 movhis.cantidads    =  ubihis.cantidads
 movhis.precio       =  0
 SetNull(movhis.codtercero)
 SetNull(movhis.numdoc)
 movhis.situacion    =  "N"
 movhis.observaciones=  sle_observaciones.text
 SetNull( movhis.punteado)
 movhis.antexist =    0
 movhis.familia      =  ubihis.familia
 movhis.subfamilia   =  ubihis.subfamilia
 movhis.formato      =  ubihis.formato
 movhis.subformato   =  ubihis.subformato
 movhis.modelo       =  ubihis.modelo
 movhis.calidad      =  ubihis.calidad
 movhis.tonochar     =  ubihis.tonochar
 movhis.calibre      =  ubihis.calibre
 movhis.tipo_unidad  =  ubihis.tipo_unidad
 movhis.referencia   =  ubihis.referencia
 movhis.f_alta       =  ubihis.f_alta
 movhis.usuario      =  ubihis.usuario
 movhis.tipo_pallet  =  ubihis.tipo_pallet
 movhis.caja    =  ubihis.caja
 movhis.sector  =  ubihis.sector
 movhis.nummov = f_almparam_nummov(movhis.empresa,Year(Date(em_fecha.text)))
 // Grabar el movimiento en el historico por el total de existencias
   IF NOT f_insert_almmovhis(movhis) Then
      MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
      bien=1
   END IF
   IF NOT f_actualiza_nummov(movhis.empresa,Year(Date(em_fecha.text)),movhis.nummov) THEN
       bien=1
		 if bien=1 then f_mensaje("Debug","2")
   END IF
 ubihis.nummov = movhis.nummov
//--------------------------------------------------------------------//
//                   la salida global               //
//--------------------------------------------------------------------//
  // En el historico de ubicaciones
   IF NOT f_insert_almlinubicahis(ubihis) THEN   bien=1
	if bien=1 then f_mensaje("Debug","3")
   IF NOT f_actualiza_numorden(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
       bien=1
		 if bien=1 then f_mensaje("Debug","4")
   END IF
   
//-------------------Fin insercion movhis salida global  ----------------\\

//----------------------------------------------
// Borro en las ubicaciones correspondientes
//----------------------------------------------

 dec registros,x1
 registros=dw_proceso.Retrieve(ubi.empresa,ubi.ubicacion,ubi.referencia,ubihis.caja)
 cantidad_borrada = 0
 IF registros<>0 THEN
	
  FOR x1=1 To registros
   cur_pedido        =  dw_proceso.GetItemNumber(x1,"pedido")
   cur_linea         =  dw_proceso.GetItemNumber(x1,"linea")
   cur_existencias   =  dw_proceso.GetItemNumber(x1,"existencias")
   cur_observaciones =  dw_proceso.GetItemString(x1,"observaciones")
   cur_tipo_pallet   =  dw_proceso.GetItemString(x1,"tipo_pallet")
   cur_caja          =  dw_proceso.GetItemString(x1,"caja")
	cur_tono          =  dw_proceso.GetItemString(x1,"tonochar")
	cur_calibre       =  dw_proceso.GetItemNumber(x1,"calibre")	
 IF (IsNull(cur_pedido) or trim(string(cur_pedido))="") and (cur_tipo_pallet = ubihis.tipo_pallet) and &
 	(cur_caja=ubihis.caja) and (cur_tono=ubihis.tonochar) &
	and (cur_calibre=ubihis.calibre)THEN
     cantidad_pendiente=Dec(em_cantidad.text) - cantidad_borrada
     IF cantidad_pendiente=0 THEN   EXIT
     IF cantidad_pendiente>= cur_existencias THEN 
         cantidad_borrada=cantidad_borrada + cur_existencias
         DELETE FROM almlinubica  
         WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
               ( almlinubica.ubicacion = :ubi.ubicacion ) AND  
               ( almlinubica.linea     = :cur_linea ) USING SQLCA;
         IF SQLCA.SQLCode<>0 THEN bien=1
			if bien=1 then f_mensaje("Debug","5")
     ELSE
         cur_existencias=cur_existencias - cantidad_pendiente
         cantidad_borrada=cantidad_borrada + cantidad_pendiente
         UPDATE almlinubica  
         SET existencias   = :cur_existencias
         WHERE ( almlinubica.empresa = :ubi.empresa ) AND  
               ( almlinubica.ubicacion = :ubi.ubicacion ) AND  
               ( almlinubica.linea = :cur_linea )USING SQLCA;
               IF SQLCA.SQLCode<>0 THEN bien=1
					if bien=1 then f_mensaje("Debug","6")
    END IF
 END IF
NEXT
END IF
IF cantidad_borrada<>Dec(em_cantidad.text) THEN  bien=1
if bien=1 then f_mensaje("Debug","7")
//--------------------------------------------------------------------//

string bloqueado,v_artdestino
// Se puede cambiar el artículo (el tono y el calibre) al que 
// va dirigido el traspaso, es decir,
// hacerse una salida del artículo seleccionado y una entrada en el 
// que se especifique en dw_1 (22/05/98 -> Mila)
// Esto es porque hay artículos con diferentes nombres
// -----------------------------------------------------------------------
// Inserto una entrada por cada linea de la datawindow
// -----------------------------------------------------------------------
  ubihis.tipomov="103"
  contador = dw_1.Rowcount()
  
FOR x1=1 TO contador
	  
	  
	  v_artdestino      = dw_1.GetItemString(x1,"articulo")
     ubihis.almacen    = dw_1.GetItemString(x1,"almacen")
     movhis.almacen    = dw_1.GetItemString(x1,"almacen")
     ubi.almacen       = dw_1.GetItemString(x1,"almacen")
     ubihis.articulo   = v_artdestino
	  ubi.articulo      = v_artdestino
	  ubihis.zona       = dw_1.GetItemString(x1,"zona")	
     ubihis.fila       = dw_1.GetItemNumber(x1,"fila")	
     ubihis.altura     = dw_1.GetItemNumber(x1,"altura")
	  ubihis.caja       = dw_1.GetItemString(x1,"caja")
	  ubihis.tipo_pallet = dw_1.GetItemString(x1,"tipo_pallet")	  
	  ubihis.tonochar   = dw_1.GetItemString(x1,"tonochar")
	  ubihis.calibre    = Dec(dw_1.GetItemString(x1,"calibre"))	
	  ubihis.calidad    = dw_1.GetItemString(x1,"calidad")
	  ubihis.referencia = f_componer_ref (ubihis.articulo,ubihis.calidad,ubihis.tonochar,ubihis.calibre)
	  //***********
  	  IF IsNull(ubihis.altura) Then ubihis.altura = 0
     ubihis.cantidade  = dw_1.GetItemDecimal(x1,"cantidad")	
     ubihis.orden      = f_almparam_numorden(codigo_empresa,Year(Date(em_fecha.text)))
     ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                                              ubihis.fila,ubihis.altura)
     ubihis.cantidads    = 0
     ubi.zona            = ubihis.zona
     ubi.fila            = ubihis.fila
     ubi.altura          = ubihis.altura
     ubi.existencias     = ubihis.cantidade
     ubi.ubicacion       = ubihis.ubicacion
	  ubi.referencia      = ubihis.referencia
	  ubi.caja            = ubihis.caja
	  ubi.tipo_pallet		 = ubihis.tipo_pallet
	  ubi.tonochar        = ubihis.tonochar
	  ubi.calibre         = ubihis.calibre
	  ubi.calidad         = ubihis.calidad
//-----------------------------------------------------------------------
// Tambien Inserto en el Historico de Movimientos ( las entradas)
//-----------------------------------------------------------------------
 movhis.empresa      =  ubihis.empresa  
 
 IF (x1=1) or (movhis.almacen <> ubihis.almacen) or &
 	(movhis.tonochar <> ubihis.tonochar) or (movhis.calibre <> ubihis.calibre) &
	or (movhis.articulo <> ubihis.articulo) Then
    otro ="S"
 ELSE
    otro = "N"
 END IF
 movhis.almacen      =  ubihis.almacen
 movhis.anyo         =  ubihis.anyo
 movhis.origen       =  "3"
 movhis.articulo     =  ubihis.articulo
 movhis.fechmov      =  ubihis.fecha
 movhis.tipomov      =  ubihis.tipomov
 movhis.cantidade    =  ubihis.cantidade
 movhis.cantidads    =  0
 movhis.precio       =  0
 SetNull(movhis.codtercero)
 SetNull(movhis.numdoc)
 movhis.situacion    =  "N"
 movhis.observaciones=  sle_observaciones.text
 SetNull( movhis.punteado)
 movhis.antexist =    0
 movhis.familia      =  f_familia_articulo(codigo_empresa,ubihis.articulo)
 movhis.subfamilia   =  f_subfamilia_articulo(codigo_empresa,ubihis.articulo)
 movhis.formato      =  f_formato_articulo(codigo_empresa,ubihis.articulo)
 movhis.subformato      =  f_subformato_articulo(codigo_empresa,ubihis.articulo)
 movhis.modelo       =  f_modelo_articulo(codigo_empresa,ubihis.articulo)
 movhis.calidad      =  ubihis.calidad
 movhis.tonochar     =  ubihis.tonochar
 movhis.calibre      =  ubihis.calibre
 movhis.tipo_unidad  =  ubihis.tipo_unidad
 movhis.referencia   =  ubihis.referencia
 movhis.f_alta       =  ubihis.f_alta
 movhis.usuario      =  ubihis.usuario
 movhis.tipo_pallet  =  ubihis.tipo_pallet
 movhis.caja         =  ubihis.caja
 IF otro ="S" Then
     movhis.nummov = f_almparam_nummov(movhis.empresa,Year(Date(em_fecha.text)))
     // Grabar el movimiento en el histórico por el total de existencias
        IF NOT f_insert_almmovhis(movhis) Then
           MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
           bien=1
        END IF
 ELSE
  UPDATE almmovhis  
     SET almmovhis.cantidade = almmovhis.cantidade + :movhis.cantidade  
   WHERE ( almmovhis.empresa = :movhis.empresa ) AND  
         ( almmovhis.almacen = :movhis.almacen ) AND  
         ( almmovhis.anyo = :movhis.anyo ) AND  
         ( almmovhis.nummov = :movhis.nummov )   ;
         IF SQLCA.SQLCode<>0 THEN
             MessageBox("Error en proceso","Modificando almmovhis",Exclamation!, OK!,1)
             bien=1
        END IF

      
    END IF
   IF NOT f_actualiza_nummov(movhis.empresa,Year(Date(em_fecha.text)),movhis.nummov) THEN
       bien=1
		 if bien=1 then f_mensaje("Debug","8")
   END IF

   ubihis.nummov = movhis.nummov

     //------------------------------------------------------------------
     // Inserto en el historico de lineas de ubicacion por movimiento
     //------------------------------------------------------------------
     IF NOT f_insert_almlinubicahis(ubihis)  Then bien=1
	  if bien=1 then f_mensaje("Debug","9")

    

      // Busco si hay lineas este articulo sin reservar
      //------------------------------------------------------
      dec grabado
     // Variable de controles 0-> no grabado 1-> si grabado
      grabado=0
      registros = 0
      registros = dw_proceso.retrieve(ubi.empresa,ubi.ubicacion,ubi.referencia,ubi.caja)
      IF registros <> 0 THEN
				FOR x21= 1 To registros	
		
				 cur_pedido       = dw_proceso.GetItemNumber(x21,"pedido")
				 cur_linea        = dw_proceso.GetItemNumber(x21,"linea")
				 cur_existencias  = dw_proceso.GetItemNumber(x21,"existencias")
				 ubi.observaciones= dw_proceso.GetItemString(x21,"observaciones")
				 cur_tipo_pallet  = dw_proceso.GetItemString(x21,"tipo_pallet")
				 cur_caja     = dw_proceso.GetItemString(x21,"caja")
				 cur_tono     = dw_proceso.GetItemString(x21,"tonochar")
				 cur_calibre  = dw_proceso.GetItemNumber(x21,"calibre")
				 cur_calidad  = dw_proceso.GetItemString(x21,"calidad")
				 ubi.tonochar = cur_tono
				 ubi.calibre  = cur_calibre
				 //¿Deberiamos controlar la calidad?\\
				  IF (IsNull(cur_pedido) or trim(string(cur_pedido))="") &
					and (cur_tipo_pallet = ubihis.tipo_pallet) and &
					(cur_caja = ubihis.caja) and (cur_tono = ubihis.tonochar) &
					and (cur_calibre = ubihis.calibre) and (cur_calidad = ubihis.calidad) THEN
					 grabado = 1
					 ubi.existencias    = ubi.existencias + cur_existencias
					 var_observaciones =  ubi.observaciones + String(today(),"dd/mm/yy") + "-" + sle_observaciones.text
					 UPDATE almlinubica  
					 SET existencias   = :ubi.existencias,   
					 f_alta            = :ubi.f_alta,
					 observaciones     = :var_observaciones
			  WHERE (almlinubica.empresa    = :ubi.empresa ) AND  
					  (almlinubica.ubicacion  = :ubi.ubicacion ) AND  
					  (almlinubica.linea      = :cur_linea ) USING SQLCA;
					  IF SQLCA.SQLCode<>0 THEN   bien=1
					  if bien=1 then f_mensaje("Debug","10")
					  EXIT
				END IF
			NEXT
		END IF
IF grabado=0 THEN
   cur_linea=0
   SELECT  max(almlinubica.linea)  INTO   :cur_linea FROM almlinubica  
   WHERE  almlinubica.empresa   = :ubi.empresa 
	AND    almlinubica.ubicacion = :ubi.ubicacion ;   
   IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN    cur_linea = 0 
   	cur_linea = cur_linea + 1
   	ubi.linea = cur_linea
   	ubi.observaciones =  String(today(),"dd/mm/yy") + "-" + sle_observaciones.text
   	IF NOT f_insert_almlinubica(ubi) Then bien=1
		if bien=1 then f_mensaje("Debug","11")
   END IF
//-----------------------Fin Grabación Lineas de Ubicacion--------------

   IF NOT f_actualiza_numorden(codigo_empresa,Year(Date(em_fecha.text)),ubihis.orden) THEN
       bien=1
		 if bien=1 then f_mensaje("Debug","12")
   END IF
NEXT
  CHOOSE CASE bien
	CASE 1
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	CASE 0
     COMMIT USING SQLCA;
   CASE ELSE
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
  END CHOOSE
  f_desbloquear_almacen(w_int_movtraspasos.title)

pb_1.enabled=TRUE

//f_listado_incidencias(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text,Trim(em_tono.text),Dec(em_calibre.text),dw_2.GetItemString(dw_2.Getrow(),"tipo_pallet"),dw_2.GetItemString(dw_2.Getrow(),"caja"))
cb_3.TriggerEvent(Clicked!)

END IF
end event

type cb_3 from u_boton within w_int_movtraspasos
boolean visible = false
integer x = 2025
integer y = 2208
integer width = 475
integer height = 84
integer taborder = 230
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;em_calibre.enabled      = TRUE
em_fecha.enabled        = TRUE
em_cantidad.enabled     = TRUE
em_cajas.enabled        = TRUE
em_palets.enabled       = TRUE
em_tono.enabled         = TRUE
uo_articulo.enabled     = TRUE
uo_calidad.enabled      = TRUE
dw_2.enabled            = TRUE
dw_3.visible            = TRUE
dw_3.retrieve(codigo_empresa,DateTime(Date(String(em_fecha.text))))



sle_observaciones.enabled = TRUE
cb_1.enabled              = TRUE
dw_1.visible              = FALSE
cb_2.visible              = FALSE
cb_3.visible              = FALSE
cb_4.visible              = FALSE
cb_borrar.visible         = FALSE

em_calibre.text=""
em_cantidad.text=""
em_cajas.text=""
em_palets.text=""
em_tono.text=""
uo_articulo.em_campo.text=""
uo_calidad.em_campo.text=""
sle_observaciones.text=""


uo_calidad.em_codigo.text=""
uo_articulo.em_codigo.text=""
dw_2.reset()
f_activar_campo(uo_articulo.em_campo)
end event

type uo_articulo from u_em_campo_2 within w_int_movtraspasos
integer x = 9
integer y = 348
integer width = 855
integer taborder = 50
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_descripcion,var_formato, v_uso
string encajados[]

Select descripcion,familia,unidad,sector,formato, uso
Into  :var_descripcion,:v_familia,:var_tipo_unidad,:v_sector,:var_formato, :v_uso
From articulos
Where articulos.empresa = :codigo_empresa
And   articulos.codigo  = :uo_articulo.em_codigo.text;

uo_articulo.em_campo.text = var_descripcion

IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF

// Visualiza las lineas de ubicación a nivel de articulo

//if ante_codigo_articulo <> uo_articulo.em_codigo.text Then
   dw_2.reset()
   SetNull(sle_observaciones.text)
   if trim(uo_articulo.em_campo.text)<>"" Then
      STRING is_filtro = ""
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()  
      dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
		dw_tipos_caja.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
   End If
   st_texto_cantidad.text=f_nombre_unidad(var_tipo_unidad)
  	em_cantidad.Setmask(DecimalMask!,f_mascara_unidad(var_tipo_unidad))
	f_mascara_columna(dw_2,"existencias",f_mascara_unidad(var_tipo_unidad))
	st_formato.text = f_nombre_formato(codigo_empresa,var_formato)

f_control_tono_calibre()


dw_5.reset()
if v_uso <> '1' then
	f_busca_encajados (uo_articulo.em_codigo.text,  encajados)
end if

if upperbound(encajados) = 0 then
	encajados[1] = uo_articulo.em_codigo.text
end if
dw_5.retrieve (codigo_empresa, encajados)

end event

event getfocus;call super::getfocus;ante_codigo_articulo = uo_articulo.em_codigo.text

ue_titulo     = "Ayuda seleccion de articulos"
//ue_datawindow = "dw_ayuda_articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type uo_calidad from u_em_campo_2 within w_int_movtraspasos
integer x = 873
integer y = 348
integer width = 142
integer taborder = 60
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)

IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF

// Visualiza las lineas de ubicación a nivel de articulo-calidad

//if ante_codigo_calidad<>uo_calidad.em_codigo.text Then

   if trim(uo_calidad.em_campo.text)<>"" Then
      STRING is_filtro = ""
      if trim(uo_articulo.em_codigo.text)<>"" then
       	is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"
	      dw_2.SetFilter(is_filtro)
         dw_2.Filter()
         dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text)
         SetNull(sle_observaciones.text)
      End If
    End If
//End if

f_control_tono_calibre()
end event

on getfocus;call u_em_campo_2::getfocus;ante_codigo_calidad = uo_calidad.em_codigo.text
ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type st_texto_cajas from statictext within w_int_movtraspasos
integer x = 4338
integer y = 276
integer width = 165
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_texto_palets from statictext within w_int_movtraspasos
integer x = 4165
integer y = 276
integer width = 169
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_cajas from u_em_campo within w_int_movtraspasos
integer x = 4334
integer y = 356
integer width = 169
integer height = 80
integer taborder = 110
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
boolean border = false
alignment alignment = right!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
string displaydata = "˜"
end type

event modificado;call super::modificado;string cadena
long posi,posi_aux

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
                          dw_2.GetItemString(dw_2.getRow(),"caja"),&
								  integer(em_palets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_palets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if




end event

event getfocus;TriggerEvent("modificado")
call super::getfocus
end event

type em_palets from u_em_campo within w_int_movtraspasos
integer x = 4165
integer y = 356
integer width = 169
integer height = 80
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
boolean border = false
alignment alignment = right!
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "###0"
string displaydata = ""
end type

event getfocus;
call super::getfocus
end event

event modificado;call super::modificado;string cadena
long posi,posi_aux

if dw_2.getRow()=0 then Return
if em_palets.text = "0" then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
                          dw_2.GetItemString(dw_2.getRow(),"caja"),&
								  integer(em_palets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_palets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if




end event

type dw_detalle from datawindow within w_int_movtraspasos
boolean visible = false
integer y = 456
integer width = 1339
integer height = 408
integer taborder = 190
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle movimiento de traspaso"
string dataobject = "dw_int_movtraspasos4"
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_2 from u_boton within w_int_movtraspasos
boolean visible = false
integer x = 1074
integer y = 2208
integer width = 475
integer height = 84
integer taborder = 250
boolean bringtotop = true
string text = "&Insertar"
end type

event clicked;integer numero,controles
Dec{2} total_pendiente,total_cantidad
String ante_almacen
string mensaje,nombre,campo
controles=0
contador=dw_1.Rowcount()
dw_1.Accepttext()
IF contador<>0 THEN
 v_almacen  = dw_1.GetItemString(contador,"almacen")	
 v_zona     = dw_1.GetItemString(contador,"zona")	
 v_fila     = dw_1.GetItemNumber(contador,"fila")	
 v_altura   = dw_1.GetItemNumber(contador,"altura")

 v_cantidad = dw_1.GetItemDecimal(contador,"cantidad")	
 dw_1.SetItem(contador,"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,dw_2.GetItemString(dw_2.GetRow(),"caja"),v_cantidad))
 v_cantidad = dw_1.GetItemDecimal(contador,"cantidad")	

 
 IF (trim(string(v_almacen))="" or IsNull(v_almacen)) and controles=0 THEN
  controles=1
  campo="almacen"
  mensaje=" Introduzca el almacen " 
 END IF

 
 IF (trim(v_zona)="" or IsNull(v_zona)) and controles=0 THEN
  controles=1
  campo="zona"
  mensaje=" Introduzca la zona "
 END IF
 IF (trim(string(v_fila))=""  or IsNull(v_fila)) and controles=0 THEN
  controles=1
  campo="fila"
  mensaje= "Introduzca la fila de la ubicacion"
 END IF
 IF (trim(string(v_altura))=""  or IsNull(v_altura)) and controles=0 THEN
  controles=1
  campo="altura"
  mensaje= "Introduzca la altura de la ubicacion"
 END IF
 IF (trim(string(v_cantidad))=""  or IsNull(v_cantidad) or v_cantidad=0) and controles=0 THEN
  controles=1
  campo="cantidad"
  mensaje= "Introduzca la cantidad"
 END IF

 nombre=f_nombre_almacen(codigo_empresa,v_almacen)
 IF (trim(nombre)="") and controles=0 THEN
   mensaje="El almacen no existe "
   controles=1
   campo="almacen"
 END IF

 nombre=f_nombre_zona(codigo_empresa,v_almacen,v_zona)
 IF (trim(nombre)="") and controles=0 THEN
    mensaje="La zona no existe"
    controles=1
    campo="zona"
 END IF
 IF (Not(f_ubi_exist(codigo_empresa,v_almacen,v_zona,v_fila,v_altura))) and controles=0 THEN
    mensaje= "La ubicacion no esta contemplada en el mapa de ubicaciones"
    controles=1
    campo="almacen"
 END IF

 IF controles=1 THEN
  MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
  dw_1.SetColumn(campo)
  dw_1.setRow(contador)
  dw_1.setfocus()
  Return
 END IF
END IF

contador=contador+1
dw_1.InsertRow(contador)

total_cantidad   = dw_1.GetItemNumber(1,"total_cantidad")
total_pendiente = dec(em_cantidad.text)-total_cantidad
dw_1.setitem(Contador,"cantidad",total_pendiente)
dw_1.setitem(contador,"empresa",codigo_empresa)
dw_1.setitem(1,"tipo_unidad",f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
dw_1.setitem(contador,"tonochar",em_tono.text)
dw_1.setitem(contador,"calibre",em_calibre.text)
dw_1.setitem(contador,"articulo",uo_articulo.em_codigo.text)

IF contador > 1 THEN
    dw_1.setitem(contador,"almacen",v_almacen)
END  IF

dw_1.setrowfocusIndicator(Hand!)
IF contador=1 THEN
  dw_1.SetColumn("almacen")
ELSE
dw_1.SetColumn("zona")
END IF
dw_1.setRow(contador)
dw_1.setfocus()





end event

type dw_listado from datawindow within w_int_movtraspasos
boolean visible = false
integer x = 978
integer y = 156
integer width = 270
integer height = 84
boolean bringtotop = true
string dataobject = "dw_int_movtraspasos5"
boolean livescroll = true
end type

type pb_listado from upb_imprimir within w_int_movtraspasos
boolean visible = false
integer x = 567
integer y = 168
integer width = 105
integer height = 88
integer taborder = 20
boolean originalsize = false
end type

event clicked;String impresora,cadena,imp
Integer j
DateTime fecha
SetNull(fecha)
SELECT ven_usuimpre.impresora_preparacion INTO :impresora FROM ven_usuimpre
Where empresa = :codigo_empresa
And   usuario = :nombre_usuario;
imp=dw_listado.Describe("Datawindow.Printer")
/*IF imp <> impresora Then
  MessageBox("Selecciona la impresora predeterminada","La impresora debe de ser" + impresora,Exclamation!,OK!,1)
  printSetup()
ELSE  */
	dw_listado.SetRedraw(FALSE)
	dw_listado.SetRedraw(TRUE)
	IF dw_listado.RowCOunt() < 11 Then
		FOr j = 1 To 10
		dw_listado.InsertRow(dw_listado.RowCOunt()+1)
		dw_listado.SetItem(dw_listado.RowCOunt(),"empresa",codigo_empresa)
		dw_listado.SetItem(dw_listado.RowCOunt(),"fpedido",fecha)
	Next
	END IF
	IF dw_listado.Print(TRUE)= 1 Then
		dw_listado.Reset()
		st_listado.visible = FALSE
		pb_listado.visible = FALSE
	END IF
	
//END IF


end event

type st_listado from statictext within w_int_movtraspasos
boolean visible = false
integer x = 686
integer y = 176
integer width = 512
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Listado Incidencias"
boolean focusrectangle = false
end type

type dw_pedidos from datawindow within w_int_movtraspasos
boolean visible = false
integer x = 1253
integer y = 156
integer width = 270
integer height = 84
integer taborder = 170
boolean bringtotop = true
string dataobject = "dw_proceso_venliped_art_cal_to_c_tp"
boolean livescroll = true
end type

type dw_ordenes from datawindow within w_int_movtraspasos
boolean visible = false
integer x = 1541
integer y = 156
integer width = 270
integer height = 84
integer taborder = 160
boolean bringtotop = true
string dataobject = "dw_proceso_almlincargas_art_cal_to_c_tp"
boolean livescroll = true
end type

type dw_proceso1 from datawindow within w_int_movtraspasos
boolean visible = false
integer x = 677
integer y = 8
integer width = 494
integer height = 96
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_proceso_almubimapa_con_reserva"
boolean livescroll = true
end type

type dw_proceso2 from datawindow within w_int_movtraspasos
boolean visible = false
integer x = 1957
integer y = 4
integer width = 672
integer height = 232
integer taborder = 140
boolean bringtotop = true
string dataobject = "dw_proceso_almlinubica_referencia"
boolean livescroll = true
end type

type st_formato from statictext within w_int_movtraspasos
integer x = 494
integer y = 276
integer width = 375
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_tipos_caja from datawindow within w_int_movtraspasos
integer x = 46
integer y = 484
integer width = 983
integer height = 300
integer taborder = 220
boolean bringtotop = true
string dataobject = "dw_cajas_articulo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_int_movtraspasos
integer x = 9
integer y = 428
integer width = 1047
integer height = 372
integer taborder = 220
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Tipos de caja del artículo (Información)"
end type

type dw_5 from datawindow within w_int_movtraspasos
integer x = 27
integer y = 2428
integer width = 4823
integer height = 612
integer taborder = 240
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ver_pedidos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type st_14 from statictext within w_int_movtraspasos
integer x = 23
integer y = 2348
integer width = 4827
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 21004543
string text = "Pedidos Pendientes"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_1 from u_datawindow_consultas within w_int_movtraspasos
integer x = 32
integer y = 1488
integer width = 4050
integer height = 720
integer taborder = 10
string dataobject = "dw_int_movtraspasos2"
boolean border = false
end type

event key;bus_campo= GetColumnName()
bus_filtro=  ""
 CHOOSE CASE bus_campo
	CASE "almacen"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
		bus_datawindow   =  "dw_ayuda_almacenes"
   CASE "zona"
     bus_titulo       = "VENTANA SELECCION DE TIPO DE ZONA "
 	  bus_datawindow   =  "dw_ayuda_almubizonas"
     bus_filtro            = "almacen='" + This.GetItemString(This.GetRow(),"almacen") + "'"
	CASE "tipo_pallet"
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE PALLETS"
		bus_datawindow = "dw_ayuda_palarticulo_abr"
		bus_filtro     = "palarticulo_articulo = '" + uo_articulo.em_codigo.text+ "' and  palarticulo_caja = '"	+This.GetItemString(This.GetRow(),"caja")+"'"
	CASE "caja"
		bus_titulo     = "VENTANA SELECCION DE CAJAS"
		bus_datawindow = "dw_ayuda_almartcajas_sin_pallet"
		bus_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"
	CASE "articulo"
		bus_titulo     = "VENTANA SELECCION DE ARTÍCULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = ""
	CASE "calidad"
		bus_titulo     = "VENTANA SELECCION DE CALIDADES"
		bus_datawindow = "dw_ayuda_calidades"
		bus_filtro   =""  
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 
 IF key = KeyTab! Then
   // Redondeo a cantidad 
   Dec{2} var_cantidad
   var_cantidad = dw_1.GetItemNumber(dw_1.GetRow(),"cantidad")
   dw_1.SetItem(dw_1.GetRow(),"cantidad",f_calculo_redondeo_cantidad(codigo_empresa,uo_articulo.em_codigo.text,dw_2.GetItemString(dw_2.GetRow(),"caja"),var_cantidad))
	END IF
	
	Call Super::Key
end event

event rbuttondown;bus_campo= GetColumnName()
bus_filtro=  ""
CHOOSE CASE bus_campo
	CASE "almacen"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
		bus_datawindow   =  "dw_ayuda_almacenes"
   CASE "zona"
     bus_titulo       = "VENTANA SELECCION DE TIPO DE ZONA "
 	  bus_datawindow   =  "dw_ayuda_almubizonas"
     bus_filtro            = "almacen='" + This.GetItemString(This.GetRow(),"almacen") + "'"
	CASE "tipo_pallet"
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE PALLETS"
		bus_datawindow = "dw_ayuda_palarticulo_abr"
		bus_filtro     = "palarticulo_articulo = '" + uo_articulo.em_codigo.text+ "' and  palarticulo_caja = '"	+This.GetItemString(This.GetRow(),"caja")+"'"
	CASE "caja"
		bus_titulo     = "VENTANA SELECCION DE CAJAS"
		bus_datawindow = "dw_ayuda_almartcajas_sin_pallet"
		bus_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"
	CASE "articulo"
		bus_titulo     = "VENTANA SELECCION DE ARTÍCULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = ""          
	CASE "calidad"
		bus_titulo     = "VENTANA SELECCION DE CALIDADES"
		bus_datawindow = "dw_ayuda_calidades"
		bus_filtro     = ""          
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 Call Super::rbuttondown
end event

type dw_3 from datawindow within w_int_movtraspasos
integer x = 37
integer y = 1492
integer width = 4809
integer height = 720
string dataobject = "dw_int_movtraspasos3"
boolean vscrollbar = true
boolean border = false
end type

on retrieveend;dw_detalle.visible = FALSE
end on

event clicked;IF row<>0 THEN
 integer registros
 registros = dw_3.RowCount()
 IF registros>0 THEN
 This.SelectRow(0,FALSE)
 This.SelectRow(row,TRUE)
 
  ubihis.anyo    =  GetItemNumber(row,"anyo")
  ubihis.almacen =  GetItemString(row,"almacen")
  ubihis.nummov  =  GetItemNumber(row,"nummov")
  dw_detalle.visible = TRUE
  dw_detalle.retrieve(codigo_empresa,ubihis.anyo,ubihis.almacen,ubihis.nummov)
 END IF
END IF
end event

type st_6 from statictext within w_int_movtraspasos
integer x = 18
integer y = 92
integer width = 4882
integer height = 2972
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "NO USAR - OBSOLETO "
alignment alignment = center!
boolean focusrectangle = false
end type

