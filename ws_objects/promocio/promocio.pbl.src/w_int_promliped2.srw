$PBExportHeader$w_int_promliped2.srw
forward
global type w_int_promliped2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_promliped2
end type
type uo_grupo from u_em_campo_2 within w_int_promliped2
end type
type st_4 from statictext within w_int_promliped2
end type
type em_descripcion from u_em_campo within w_int_promliped2
end type
type st_8 from statictext within w_int_promliped2
end type
type dw_detalle from datawindow within w_int_promliped2
end type
type em_cantidad from u_em_campo within w_int_promliped2
end type
type st_9 from statictext within w_int_promliped2
end type
type dw_proceso2 from datawindow within w_int_promliped2
end type
type st_1 from statictext within w_int_promliped2
end type
type st_2 from statictext within w_int_promliped2
end type
type em_anyo from u_em_campo within w_int_promliped2
end type
type em_pedido from u_em_campo within w_int_promliped2
end type
type dw_1 from u_datawindow_consultas within w_int_promliped2
end type
type dw_control from datawindow within w_int_promliped2
end type
end forward

global type w_int_promliped2 from w_int_con_empresa
integer width = 2990
integer height = 2064
boolean maxbox = false
windowtype windowtype = popup!
pb_1 pb_1
uo_grupo uo_grupo
st_4 st_4
em_descripcion em_descripcion
st_8 st_8
dw_detalle dw_detalle
em_cantidad em_cantidad
st_9 st_9
dw_proceso2 dw_proceso2
st_1 st_1
st_2 st_2
em_anyo em_anyo
em_pedido em_pedido
dw_1 dw_1
dw_control dw_control
end type
global w_int_promliped2 w_int_promliped2

type variables
Dec{0} var_anyo,var_pedido
String var_usuario_pedido,cod_panel,var_reposicion
EditMAsk campo
String  marcado,var_tipo,var_tipo_expositor,var_clase_panel,var_mano
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_grabar_linea (string var_panel)
public subroutine f_borrar_linea (string var_panel)
end prototypes

public subroutine f_control ();
String descripcion,filtro,codpanel
Dec{0} numero,v_anyo,v_pedido

dw_1.SetRedraw(False)
filtro = ""
dw_1.Setfilter(filtro)
descripcion = "%"+em_descripcion.text+"%"

IF var_tipo = "2" Then
	filtro = "control = 'X'"
	descripcion = "%"
END IF

IF Trim(uo_grupo.em_codigo.text) <> "" and Not IsNull(uo_grupo.em_codigo.text) Then
	IF len(filtro) <>0 Then filtro = filtro + " And "
	 filtro = filtro +"grupo = '" + uo_grupo.em_codigo.text+"'"
END IF

dw_1.Setfilter(filtro)
dw_1.filter()


     var_anyo            = Dec(istr_parametros.s_argumentos[2])
     var_pedido          = Dec(istr_parametros.s_argumentos[3])
	  cod_panel           = istr_parametros.s_argumentos[4]
	  var_usuario_pedido  = istr_parametros.s_argumentos[5]
	  em_anyo.text        = istr_parametros.s_argumentos[2]
     em_pedido.text      = istr_parametros.s_argumentos[3]
	  var_tipo_expositor  = istr_parametros.s_argumentos[6]
	  var_clase_panel     = istr_parametros.s_argumentos[7]
	  IF var_mano= "S" Then
			dw_1.Retrieve(codigo_empresa,descripcion,var_anyo,var_pedido)
		ELSE
			dw_1.Retrieve(codigo_empresa,descripcion,var_anyo,var_pedido,var_tipo_expositor)
	END IF

IF len(var_tipo_expositor) = 0  Then SetNull(var_tipo_expositor)
dw_control.Retrieve(codigo_empresa,var_anyo,var_pedido,var_tipo_expositor,var_reposicion)

if dw_1.GetRow()<>0 then 
	codpanel = dw_1.GetItemString(dw_1.Getrow(),"codigo")
	dw_detalle.Retrieve(codigo_empresa,codpanel)
End if
dw_1.SetRedraw(True)

end subroutine

public subroutine f_grabar_linea (string var_panel);Integer registro,registro2,registros2,bien,numero
Dec{0}   var_canpantipo,var_canpantipoped
String   var_medida
str_promlindetallped detalle
str_promlinped linped

IF var_reposicion = "S" Then
	if dw_1.GetRow()<>0 then 
	cod_panel                = dw_1.GetItemString(dw_1.Getrow(),"codigo")
	linped.numserie = f_numserie_promped(codigo_empresa,var_anyo,var_pedido)
	  SELECT Count(*)  
    INTO :numero  
    FROM promlinalb
   WHERE promlinalb.empresa = :codigo_empresa 
	AND   promlinalb.numserie  = :linped.numserie 
	AND   promlinalb.panel  = :cod_panel 
	AND   promlinalb.activo   = "S"   ;
			iF IsNull(numero ) Then numero = 0
			IF numero<> 0 Then 
				f_mensaje("Panel Incorrecto"," El panel ya existe en el expositor a reponer")
				return
			END IF
		END IF
	
END IF




bien =0	

linped.empresa   = codigo_empresa
linped.anyo      = var_anyo
linped.pedido    = var_pedido
linped.panel     = var_panel
linped.cantidad  = Dec(em_cantidad.text)
linped.situacion = "C"
linped.tipo_panel = f_tipo_panel_prompaneles(codigo_empresa,linped.panel)
linped.clase_panel = var_clase_panel

SELECT   promped.fpedido,   
         promped.fentrega,   
         promped.cliente,   
			promped.tipo_cliente,   
         promped.agente1,   
         promped.agente2,   
         promped.usuario_pedido,   
         promped.agente3,   
         promped.tipo_expositor,   
         promped.expositor,   
         promped.tipo,   
         promped.pais,   
         promped.reposicion 
    INTO :linped.f_pedido,   
         :linped.f_entrega,   
         :linped.cliente,   
         :linped.tipo_cliente,   
         :linped.agente1,   
         :linped.agente2,   
         :linped.usuario_pedido,   
         :linped.agente3,   
         :linped.tipo_expositor,   
         :linped.expositor,   
         :linped.tipo,   
         :linped.pais,   
         :linped.reposicion
    FROM promped  
   WHERE ( promped.empresa = :linped.empresa ) AND  
         ( promped.anyo = :linped.anyo ) AND  
         ( promped.pedido = :linped.pedido )   ;

Select max(promlinped.linea) Into :linped.linea From promlinped
Where  promlinped.empresa   = :codigo_empresa
And    promlinped.anyo      = :var_anyo
And    promlinped.pedido    = :var_pedido;

If IsNull(linped.linea) Then linped.linea = 0

linped.linea = linped.linea + 1
linped.peso_material  = f_pesomaterial_prompaneles(codigo_empresa,linped.panel)
linped.coste_material = f_costematerial_prompaneles(codigo_empresa,linped.panel)
linped.venta_material = f_pventamaterial_prompaneles(codigo_empresa,linped.panel)

IF linped.tipo = "2" Then
	   var_medida         = f_medida_promlinexpositores(codigo_empresa,linped.tipo_expositor,linped.tipo_panel)
    	linped.coste_manipulacion = f_costemanipulacion_prommedidas(codigo_empresa,var_medida)
		linped.peso_panel  = f_peso_promclasemedidas(codigo_empresa,linped.clase_panel,var_medida)
		linped.coste_panel = f_preciocoste_promclasemedidas(codigo_empresa,linped.clase_panel,var_medida)
		linped.venta_panel = f_precioventa_promclasemedidas(codigo_empresa,linped.clase_panel,var_medida)
		linped.cantidad= 1
  ELSE
   	linped.peso_panel  = f_pesopanel_promparam(codigo_empresa)
   	linped.coste_panel = f_costepanel_promparam(codigo_empresa)
   	linped.venta_panel = f_pventapanel_promparam(codigo_empresa)
		linped.coste_manipulacion =0
END IF	

linped.usuario        = nombre_usuario
linped.control_libre        = ""
if linped.tipo <>"1" then 
 IF var_reposicion= "N" Then	
 	var_canpantipo = f_total_tipo_paneles_expositor(codigo_empresa,linped.tipo_expositor,linped.tipo_panel)
 ELSE
	var_canpantipo = f_total_tipo_prompedreposicion(codigo_empresa,linped.anyo,linped.pedido,linped.tipo_panel)
 END IF
 
 IF var_canpantipo  = 0 Then
	f_mensaje("No se puede grabar la linea","Este tipo de panel no esta contemplado en el expositor: "+f_nombre_promexpositores(codigo_empresa,linped.tipo_expositor))
	Return
  Else	
	
		Select sum(cantidad) Into :var_canpantipoped From promlinped
		Where  promlinped.empresa    = :codigo_empresa
		And    promlinped.anyo          = :var_anyo
		And    promlinped.pedido        = :var_pedido
		And    promlinped.tipo_panel    = :linped.tipo_panel;
		IF var_canpantipoped >= var_canpantipo Then
			f_mensaje("No se puede grabar la linea","Paneles de este tipo completos")
			Return
		END IF
	END IF
End If
linped.numserie = f_numserie_promped(linped.empresa,linped.anyo,linped.pedido)
INSERT INTO promlinped  
         ( empresa,   
           anyo,   
           pedido,   
           linea,   
           cliente,   
			  tipo_cliente,
           pais,   
           tipo,   
           reposicion,   
           panel,   
           cantidad,   
           peso_panel,   
           coste_panel,   
           venta_panel,   
           peso_material,   
           coste_material,   
           venta_material,
			  usuario,
			  usuario_pedido,
			  situacion,
			  control_libre,
			  f_pedido,
			  f_entrega,
			  agente1,
			  agente2,
			  agente3,
			  tipo_expositor,
			  expositor,
			  tipo_panel,
			  clase_panel,
			  coste_manipulacion,
			  numserie,
			  cambio_composicion)  
  VALUES ( :linped.empresa,   
           :linped.anyo,   
           :linped.pedido,   
           :linped.linea,   
           :linped.cliente,   
			  :linped.tipo_cliente,   
           :linped.pais,   
           :linped.tipo,   
           :linped.reposicion,   
           :linped.panel,   
           :linped.cantidad,   
           :linped.peso_panel,   
           :linped.coste_panel,   
           :linped.venta_panel,   
           :linped.peso_material,   
           :linped.coste_material,   
           :linped.venta_material,
  			  :linped.usuario,
			  :linped.usuario_pedido,
			  :linped.situacion,
  			  :linped.control_libre,
			  :linped.f_pedido,
			  :linped.f_entrega,
			  :linped.agente1,
			  :linped.agente2,
			  :linped.agente3,
			  :linped.tipo_expositor,
			  :linped.expositor,
			  :linped.tipo_panel,
			  :linped.clase_panel,
			  :linped.coste_manipulacion,
			  :linped.numserie,
			  "N");
			  IF sqlca.SqlCode <> 0 then
				bien = 1
				f_mensaje("Error en datos",sqlca.sqlerrtext)
			END IF
	  
	  registros2 =  dw_proceso2.Retrieve(codigo_empresa,linped.panel)
	  IF registros2 <> 0 THEN
	    FOR registro2 = 1 To registros2
			detalle.empresa = codigo_empresa
			detalle.anyo    = linped.anyo
			detalle.pedido  = linped.pedido
			detalle.linea   = linped.linea
			detalle.orden   = registro2
			detalle.panel   = linped.panel
			detalle.articulo = dw_proceso2.GetItemString(registro2,"articulo")
			detalle.calidad  = dw_proceso2.GetItemString(registro2,"calidad")
			detalle.montajeartcal  = dw_proceso2.GetItemString(registro2,"montajeartcal")
			detalle.piezas         = dw_proceso2.GetItemDecimal(registro2,"piezas")
			detalle.usuario        = linped.usuario
			detalle.usuario_pedido = linped.usuario_pedido
			detalle.observaciones=""
			detalle.peso= dw_proceso2.GetItemDecimal(registro2,"peso")
			detalle.coste= dw_proceso2.GetItemDecimal(registro2,"coste")
			detalle.venta= dw_proceso2.GetItemDecimal(registro2,"pventa")
			detalle.pais     = linped.pais
			detalle.cliente  = linped.cliente
			detalle.tipo     = linped.tipo
			detalle.reposicion= linped.reposicion
			detalle.situacion = linped.situacion
			detalle.f_pedido  = linped.f_pedido
			detalle.f_entrega = linped.f_entrega
			detalle.agente1   = linped.agente1
			detalle.agente2   = linped.agente2
			detalle.agente3   = linped.agente3
			detalle.tipo_expositor= linped.tipo_expositor
			detalle.expositor     = linped.expositor
			  INSERT INTO promlindetallped  
         ( empresa,   
           anyo,   
           pedido,   
           linea,   
           orden,   
           panel,   
           articulo,   
           calidad,   
           montajeartcal,   
           piezas,   
           usuario,   
           usuario_pedido,   
           observaciones,   
           peso,   
           coste,   
           venta,   
           pais,   
           cliente,
			  tipo,
			  reposicion,
			  situacion,
			  f_pedido,
			  f_entrega,
			  agente1,
			  agente2,
			  agente3,
			  tipo_expositor,
			  expositor)  
  VALUES ( :detalle.empresa,   
           :detalle.anyo,   
           :detalle.pedido,   
           :detalle.linea,   
           :detalle.orden,   
           :detalle.panel,   
           :detalle.articulo,   
           :detalle.calidad,   
           :detalle.montajeartcal,   
           :detalle.piezas,   
           :detalle.usuario,   
           :detalle.usuario_pedido,   
           :detalle.observaciones,   
           :detalle.peso,   
           :detalle.coste,   
           :detalle.venta,   
           :detalle.pais,   
           :detalle.cliente,
  			  :detalle.tipo,
			  :detalle.reposicion,
			  :detalle.situacion,
			  :detalle.f_pedido,
			  :detalle.f_entrega,
			  :detalle.agente1,
			  :detalle.agente2,
			  :detalle.agente3,
			  :detalle.tipo_expositor,
			  :detalle.expositor)  ;

			  IF sqlca.Sqlcode<> 0 Then 
					bien = 1
					f_mensaje("Error en datos",sqlca.sqlerrtext)
					Exit
  			  END IF
			
			
		NEXT
	  END IF		
	

	If bien = 0 then
		  COMMIT;
	ELSE
		  ROLLBACK;
		  f_mensaje("Error en proceso de datos"," No se pudo grabar el detalle del expositor")
	END IF

end subroutine

public subroutine f_borrar_linea (string var_panel);
  DELETE FROM promlinped  
   WHERE ( promlinped.empresa = :codigo_empresa ) AND  
         ( promlinped.anyo = :var_anyo ) AND  
         ( promlinped.pedido = :var_pedido ) AND  
         ( promlinped.panel = :var_panel )   ;


  DELETE FROM promlindetallped  
   WHERE ( promlindetallped.empresa = :codigo_empresa ) AND  
         ( promlindetallped.anyo = :var_anyo ) AND  
         ( promlindetallped.pedido = :var_pedido ) AND  
         ( promlindetallped.panel = :var_panel );
COMMIT;
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccion Detalle Paneles(Pedidos Promocion)"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetRowFocusIndicator(Hand!)
marcado= "N"
dw_detalle.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_control.SetTransObject(SQLCA)
var_tipo = "1"
  
  // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      var_anyo           = Dec(istr_parametros.s_argumentos[2])
      var_pedido         = Dec(istr_parametros.s_argumentos[3])
		cod_panel          = istr_parametros.s_argumentos[4]
		var_usuario_pedido = istr_parametros.s_argumentos[5]
		var_reposicion = istr_parametros.s_argumentos[8]
		IF istr_parametros.s_argumentos[9] = "1" Then
			var_mano = "S"
			dw_1.DataObject="dw_int_promlinped7"
		ELSE
			dw_1.DataObject="dw_int_promlinped3"
			var_mano= "N"
		END IF
	dw_1.SetTransObject(SQLCA)
   	IF cod_panel = "S" Then
			dw_control.visible = FALSE
	     Else
			dw_control.visible = TRUE
		END IF
		
		em_anyo.text   = istr_parametros.s_argumentos[2]
      em_pedido.text = istr_parametros.s_argumentos[3]
	   var_tipo_expositor = istr_parametros.s_argumentos[6]
	 	var_clase_panel         = istr_parametros.s_argumentos[7]
      em_cantidad.text = "1"
      f_control()
      f_activar_campo(em_descripcion)
      Return 
END IF
em_cantidad.text = "1"
f_control()
f_activar_campo(uo_grupo.em_campo)

end event

event key;call super::key;If campo = em_descripcion Then 
	IF key = KeyEnter! or key = keyTab! Then
	     f_control()
   END IF
END IF


end event

on w_int_promliped2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_grupo=create uo_grupo
this.st_4=create st_4
this.em_descripcion=create em_descripcion
this.st_8=create st_8
this.dw_detalle=create dw_detalle
this.em_cantidad=create em_cantidad
this.st_9=create st_9
this.dw_proceso2=create dw_proceso2
this.st_1=create st_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_pedido=create em_pedido
this.dw_1=create dw_1
this.dw_control=create dw_control
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_grupo
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.em_descripcion
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.em_cantidad
this.Control[iCurrent+8]=this.st_9
this.Control[iCurrent+9]=this.dw_proceso2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.em_anyo
this.Control[iCurrent+13]=this.em_pedido
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.dw_control
end on

on w_int_promliped2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_grupo)
destroy(this.st_4)
destroy(this.em_descripcion)
destroy(this.st_8)
destroy(this.dw_detalle)
destroy(this.em_cantidad)
destroy(this.st_9)
destroy(this.dw_proceso2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_pedido)
destroy(this.dw_1)
destroy(this.dw_control)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_abajo(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event activate;call super::activate;w_int_promliped2 = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_promliped2
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_promliped2
integer taborder = 40
end type

event sle_opcion_orden::getfocus;call super::getfocus; f_control()
f_activar_campo(em_descripcion)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_promliped2
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_promliped2
integer x = 2743
integer y = 4
integer width = 137
integer height = 120
integer taborder = 0
end type

event clicked;IF dw_control.RowCount() <> 0 Then 
Integer total1,total2

	total1 = Dec(f_valor_columna(dw_control,dw_control.RowCount(),"total1"))
	total2 = Dec(f_valor_columna(dw_control,dw_control.RowCount(),"total2"))
	IF total1 <> total2 Then
		f_mensaje("-- Aviso --","Existen paneles sin asignar al expositor")
	END IF
END IF
CLosewithreturn(w_int_promliped2,"1")
end event

type uo_grupo from u_em_campo_2 within w_int_promliped2
integer x = 773
integer y = 196
integer width = 425
integer height = 88
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de grupos"
ue_datawindow = "dw_ayuda_promgrupos"
ue_filtro     = ""
campo = uo_grupo.em_campo
end on

on modificado;call u_em_campo_2::modificado;uo_grupo.em_campo.text=f_nombre_promgrupos(codigo_empresa,uo_grupo.em_codigo.text)
IF Trim(uo_grupo.em_campo.text)="" THEN 
 IF Trim(uo_grupo.em_codigo.text)<>"" Then uo_grupo.em_campo.SetFocus()
 uo_grupo.em_campo.text=""
 uo_grupo.em_codigo.text=""
END IF

f_control()
 
end on

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_int_promliped2
integer x = 777
integer y = 124
integer width = 425
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
string text = "Grupo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_descripcion from u_em_campo within w_int_promliped2
integer x = 1198
integer y = 196
integer width = 1088
integer height = 88
integer taborder = 30
end type

event getfocus;call super::getfocus;campo = this
end event

type st_8 from statictext within w_int_promliped2
integer x = 1202
integer y = 124
integer width = 1083
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
string text = "Descripción"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_detalle from datawindow within w_int_promliped2
integer y = 1220
integer width = 2299
integer height = 580
boolean bringtotop = true
string dataobject = "dw_int_promlinped4"
boolean vscrollbar = true
boolean livescroll = true
end type

type em_cantidad from u_em_campo within w_int_promliped2
integer x = 2286
integer y = 196
integer width = 293
integer height = 88
integer taborder = 0
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

on modificado;call u_em_campo::modificado;IF em_cantidad.text="" or em_cantidad.text="0" Then
em_cantidad.text="1"
END IF
end on

on getfocus;call u_em_campo::getfocus;campo = this
end on

type st_9 from statictext within w_int_promliped2
integer x = 2286
integer y = 124
integer width = 293
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
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_proceso2 from datawindow within w_int_promliped2
boolean visible = false
integer x = 229
integer width = 1335
integer height = 168
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_proceso_prommapapaneles"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_int_promliped2
integer x = 137
integer y = 124
integer width = 265
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Año"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_promliped2
integer x = 402
integer y = 124
integer width = 375
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Pedido"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_int_promliped2
integer x = 137
integer y = 196
integer width = 265
integer height = 88
integer taborder = 0
alignment alignment = right!
boolean displayonly = true
string displaydata = ""
end type

type em_pedido from u_em_campo within w_int_promliped2
integer x = 402
integer y = 196
integer width = 370
integer height = 88
integer taborder = 0
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
end type

type dw_1 from u_datawindow_consultas within w_int_promliped2
integer y = 292
integer width = 2843
integer height = 916
integer taborder = 10
string dataobject = "dw_int_promlinped3"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;Integer linea,lin,cantidad
Dec  anyo,pedido
String panel,controles,situacion
Dec{2}  pesomaterial,costematerial,ventamaterial
lin  =  This.getRow()
If lin =0 Then Return
panel  = dw_1.GetItemString(lin,"codigo")
anyo   = var_anyo
pedido = var_pedido

Select promlinped.situacion Into :situacion From promlinped
Where  promlinped.empresa  = :codigo_empresa
And    promlinped.anyo     = :anyo
And    promlinped.pedido   = :pedido
And    promlinped.panel    = :panel;
IF SQLCA.SQLCODE < 0 Then f_mensaje("Error en base de datos",sqlca.sqlerrtext)

IF situacion = "P" Then
	f_mensaje("Esta linea no se puede desmarcar","Pedido preparado")
	return
END IF
IF situacion= "S" Then
	f_mensaje("Esta linea no se puede desmarcar","Pedido Servido")
	return
END IF

   panel            = dw_1.GetItemString(lin,"codigo")
   controles = dw_1.GetItemString(lin,"control")
IF controles = "" Then
   f_grabar_linea(panel)
ELSE
   f_borrar_linea(panel)
   COMMIT;
END IF
f_asignar_columna(dw_1,dw_1.GetRow(),"empresa",codigo_empresa)
dw_control.Retrieve(codigo_empresa,Dec(em_anyo.text),dec(em_pedido.text),var_tipo_expositor,var_reposicion)
f_activar_campo(em_descripcion)
end event

event rowfocuschanged;call super::rowfocuschanged;String panel
IF dw_1.GetRow() =0 Then Return
panel = dw_1.GetItemString(dw_1.GetRow(),"codigo")
dw_detalle.Retrieve(codigo_empresa,panel)
end event

event clicked;call super::clicked;IF f_objeto_datawindow(This) = "marcado" Then
IF var_tipo = "1" Then
	var_tipo = "2"
Else
	var_tipo = "1"
END IF
f_control()
END IF

f_activar_campo(em_descripcion)
end event

event ue_valores;call super::ue_valores;ue_marca_linea = FALSE
end event

type dw_control from datawindow within w_int_promliped2
integer x = 2299
integer y = 1220
integer width = 576
integer height = 360
boolean bringtotop = true
string dataobject = "dw_int_promlinped6"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

