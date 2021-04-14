$PBExportHeader$w_confirmacion_alb_con_alm.srw
forward
global type w_confirmacion_alb_con_alm from w_int_con_empresa
end type
type pb_1 from upb_salir within w_confirmacion_alb_con_alm
end type
type uo_proveedor from u_em_campo_2 within w_confirmacion_alb_con_alm
end type
type uo_manejo from u_manejo_datawindow within w_confirmacion_alb_con_alm
end type
type gb_5 from groupbox within w_confirmacion_alb_con_alm
end type
type gb_1 from groupbox within w_confirmacion_alb_con_alm
end type
type cb_1 from commandbutton within w_confirmacion_alb_con_alm
end type
type cb_2 from commandbutton within w_confirmacion_alb_con_alm
end type
type em_anyo2 from u_em_campo within w_confirmacion_alb_con_alm
end type
type em_alb from u_em_campo within w_confirmacion_alb_con_alm
end type
type uo_mprima from u_em_campo_2 within w_confirmacion_alb_con_alm
end type
type gb_2 from groupbox within w_confirmacion_alb_con_alm
end type
type st_8 from statictext within w_confirmacion_alb_con_alm
end type
type gb_3 from groupbox within w_confirmacion_alb_con_alm
end type
type cb_3 from commandbutton within w_confirmacion_alb_con_alm
end type
type gb_7 from groupbox within w_confirmacion_alb_con_alm
end type
type gb_6 from groupbox within w_confirmacion_alb_con_alm
end type
type st_1 from statictext within w_confirmacion_alb_con_alm
end type
type dw_1 from u_datawindow within w_confirmacion_alb_con_alm
end type
end forward

shared variables
string pul='N'
end variables

global type w_confirmacion_alb_con_alm from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 2935
integer height = 1696
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
gb_7 gb_7
gb_6 gb_6
st_1 st_1
dw_1 dw_1
end type
global w_confirmacion_alb_con_alm w_confirmacion_alb_con_alm

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
public subroutine f_control (integer ln)
public function boolean f_datos_comunes_almacen ()
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

public subroutine f_control (integer ln);IF dw_1.GetItemString(ln,"comlinalb_libre") = "B" Then
	dw_1.SetTabOrder("comlinalb_cantidad",20)
ELSE
	dw_1.SetColumn("comlinalb_libre")
	dw_1.SetTabOrder("comlinalb_cantidad",0)
END IF
end subroutine

public function boolean f_datos_comunes_almacen ();/* ----------------------------------------------------------- */
/* Datos invariables para el histórico de ubicaciones          */
/* ----------------------------------------------------------- */
ubihis.usuario    = nombre_usuario
ubihis.empresa    = codigo_empresa
ubihis.anyo       = Year(Today())
ubihis.articulo   = mprima
ubihis.referencia = mprima
ubihis.fecha      = DateTime(Today(),Now())
ubihis.f_alta     = DateTime(Today(),Now())
ubihis.tipo_unidad= unidad
ubihis.observaciones = ""

// Datos de la materia
SELECT venmprima.familia //, venmprima.tipo_materia
	INTO :ubihis.familia //,:ubihis.tipo_materia
	FROM venmprima  
	WHERE (venmprima.empresa= :ubihis.empresa ) AND  
			(venmprima.codigo = :ubihis.articulo )   
	USING SQLCA ;
	
IF SQLCA.SQLCode<>0 THEN 
	f_mensaje("Error","No se encontró el artículo en la tabla VENMPRIMA.")
	Return FALSE
END IF

/* ----------------------------------------------------------- */
/* Datos invariables para la tabla de ubicaciones     			*/
/* ----------------------------------------------------------- */
ubi.empresa    =  ubihis.empresa
ubi.articulo   =  ubihis.articulo
ubi.familia    =  ubihis.familia
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad  = ubihis.tipo_unidad
//ubi.tipo_materia = ubihis.tipo_materia
ubi.referencia   = ubihis.referencia
ubi.f_alta       = ubihis.f_alta

Return TRUE
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Confirmación de Albaranes"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
//dw_proceso.SetTransObject(SQLCA)
em_anyo2.text=string(year(today()))
f_activar_campo(uo_proveedor.em_campo)
end event

event ue_listar;//dw_listado_proveedores.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text,uo_proveedor.em_codigo.text)
//dw_report=dw_listado_proveedores
//CALL Super::ue_listar
end event

on w_confirmacion_alb_con_alm.create
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
this.gb_7=create gb_7
this.gb_6=create gb_6
this.st_1=create st_1
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
this.Control[iCurrent+15]=this.gb_7
this.Control[iCurrent+16]=this.gb_6
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.dw_1
end on

on w_confirmacion_alb_con_alm.destroy
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
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.st_1)
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

event activate;call super::activate;w_confirmacion_alb_con_alm = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_confirmacion_alb_con_alm
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_confirmacion_alb_con_alm
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_confirmacion_alb_con_alm
integer x = 41
integer y = 12
integer width = 2679
end type

type pb_1 from upb_salir within w_confirmacion_alb_con_alm
integer x = 2752
integer y = 4
integer width = 123
integer height = 116
integer taborder = 0
end type

type uo_proveedor from u_em_campo_2 within w_confirmacion_alb_con_alm
integer x = 1609
integer y = 204
integer width = 882
integer taborder = 70
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

type uo_manejo from u_manejo_datawindow within w_confirmacion_alb_con_alm
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

type gb_5 from groupbox within w_confirmacion_alb_con_alm
integer x = 2533
integer y = 116
integer width = 343
integer height = 200
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_confirmacion_alb_con_alm
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

type cb_1 from commandbutton within w_confirmacion_alb_con_alm
integer x = 2546
integer y = 1300
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

event clicked;//Long   bien
//Long   total_lineas,i,linea=0
//String proceso
//
//dw_1.AcceptText()
//
//total_lineas=dw_1.rowcount()
//
///**********************************************************************/
///*						PROCESO POR CADA LÍNEA DE DW_1                      */
///**********************************************************************/
//
//FOR i=1 TO total_lineas
//	
//	proceso=dw_1.getitemstring(i,"comlinalb_libre")
//
//	IF proceso <> "N" THEN
//		
//		String   pedido, linped, anyo_st
//		String   obs, anyo_ped,provee
//		DateTime frech
//		Dec      precio
//		Integer	anyo_exis = Year(Today())
//		
//		anyo_st   = dw_1.GetItemString(i,"comlinalb_anyo")
//		albaran   = dw_1.GetItemString(i,"comlinalb_albaran")
//		linea_alb = dw_1.GetItemString(i,"comlinalb_linea")
//		mprima    = dw_1.GetItemString(i,"comlinalb_mprima")
//		cantidad  = dw_1.GetItemNumber(i,"comlinalb_cantidad")
//		precio    = dw_1.GetItemNumber(i,"comlinalb_precio")
//		fecha     = dw_1.GetItemDateTime(i,"comlinalb_fecha_entrega")
//		unidad    = dw_1.GetItemString(i,"comlinalb_unidad_medida")
//		pedido    = dw_1.GetItemString(i,"comlinalb_pedido")
//		linped    = dw_1.GetItemString(i,"comlinalb_linea_pedido")
//		obs       = dw_1.GetItemString(i,"comlinalb_observaciones")
//		anyo_ped  = dw_1.GetItemString(i,"comlinalb_anyo_pedido")
//		provee    = dw_1.GetItemString(i,"comcabalb_proveedor")
//		frech     = DateTime(Today(),Now())
//		
//		// linea rechazada, inserta en COMHISRECHAZOS.
//		IF proceso = "M" THEN
//			
//			INSERT INTO comhisrechazos
//         				(empresa,anyo,albaran,linea,mprima,cantidad,   
//           				 precio,fecha_entrega,unidad_medida,pedido,   
//           				 linea_pedido,observaciones,libre,anyo_pedido,
//			  				 fecha_rechazo,proveedor)
//  				VALUES ( :codigo_empresa,:anyo_st,:albaran,:linea_alb,
//  			  				:mprima,:cantidad,:precio,:fecha,:unidad,:pedido,   
//           				:linped,:obs,null,:anyo_ped,:frech,:provee)  ;
//							  
//			IF sqlca.sqlcode<>0 THEN 
//				bien = bien + 1
//			END IF
//			
//			// borra la linea rechazada de comlinalb
//			DELETE FROM comlinalb 
//   		WHERE ( comlinalb.empresa = :codigo_empresa ) AND  
//         		( comlinalb.anyo	  = :anyo_st) AND  
//         		( comlinalb.albaran = :albaran) AND  
//         		( comlinalb.linea   = :linea_alb)   ;
//			
//			IF sqlca.sqlcode<>0 THEN 
//				bien = bien + 1
//			END IF
//			
//			// inserta la linea en pedidos, comprobando si existe.
//			Dec existe
//			SELECT count(*) INTO :existe FROM comlinpedpro  
//			WHERE ( comlinpedpro.empresa = :codigo_empresa ) AND  
//					( comlinpedpro.anyo    = :anyo_ped ) AND  
//					( comlinpedpro.pedido  = :pedido) AND  
//					( comlinpedpro.linea   = :linped)   ;
//			
//			IF sqlca.sqlcode<>0 THEN
//				existe=0
//			END IF
//			
//			// Si existe, aumenta la cantidad
//			IF existe<>0 THEN
//				
//				UPDATE comlinpedpro  
//				SET comlinpedpro.cantidad = comlinpedpro.cantidad + :cantidad  
//				WHERE ( comlinpedpro.empresa = :codigo_empresa ) AND  
//						( comlinpedpro.anyo    = :anyo_ped ) AND  
//						( comlinpedpro.pedido  = :pedido) AND  
//						( comlinpedpro.linea   = :linped)   ;
//				
//				IF sqlca.sqlcode<>0 THEN
//					bien = bien + 1
//				END IF
//				
//			ELSE
//				// Sino, inserta linea
//				INSERT INTO comlinpedpro  
//					( empresa,anyo,pedido,linea,mprima,cantidad,precio,   
//					 fecha_entrega,unidad_medida,observaciones,libre )  
//				VALUES
//					( :codigo_empresa,:anyo_ped,:pedido,:linped,:mprima,   
//					 :cantidad,:precio,:fecha,:unidad,:obs,null )  ;
//					 
//				IF sqlca.sqlcode<>0 THEN  
//					bien = bien + 1
//				END IF
//			END IF
//		END IF  // FIN DE PROCESO ="M"
//		
//		// linea OK
//		IF proceso = "B" THEN
//			datetime fech_control
//			boolean ok
//			
//			fech_control=datetime(today(),now())
//			UPDATE comlinalb  
//     		SET situacion    = 'C',
//				 fecha_control=:fech_control				
//   		WHERE ( comlinalb.empresa =:codigo_empresa  ) AND  
//         		( comlinalb.anyo    =:anyo_st ) AND  
//         		( comlinalb.albaran =:albaran  ) AND  
//         		( comlinalb.linea   =:linea_alb  )   ;
//			// Ubicamos la lineas confirmadas directamente dicho por
//			// Yolanda el 21/11/97, en almacen 1 y lote 0000
//			f_datos_comunes_almacen()
//						
//			/***********************************************************/
//			/*	PROCESO 1: ENTRADA A REALIZAR POR CADA LÍNEA CONFIRMADA */
//			/***********************************************************/
//	
//			// ........ PARA EL HISTÓRICO DE UBICACIONES
//			ubihis.almacen = '1'
//			ubihis.zona    = '1'
//			ubihis.fila    = 1
//			ubihis.altura  = 1
//			ubihis.lote    = '0000'
//			SELECT venmprima.envase INTO :ubihis.envase FROM venmprima
//			WHERE venmprima.empresa = :codigo_empresa
//			AND   venmprima.codigo  = :mprima;
//			ubihis.cantidade = cantidad
//			ubihis.cantidads = 0
//			ubihis.ubicacion = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
//									 ubihis.fila,ubihis.altura)
//			ubihis.tipomov   = '107'
//			
//			Integer     mov_entrada, mov_salida,longitudes
//			
//			// Cálculo del número de orden
//			titulo        =  "Confirmacion albaranes"
//			longitudes    =  Len(Trim(codigo_empresa))
//			criterio[1]   =  Trim(codigo_empresa)+ Space(20-longitudes)
//			anyo          =  Year(Today())
//			longitudes    =  Len(Trim(String(anyo_exis)))
//			criterio[2]   =  Trim(String(anyo)) + Space(20-longitudes)
//			longitudes    =  Len(Trim(ubihis.almacen))
//			criterio[3]   =  Trim(ubihis.almacen) + Space(20-longitudes)
//			seleccion     =  criterio[1]+criterio[2]+criterio[3]
//			tabla         =  "almparam"
//
//			IF f_bloquear(tabla,seleccion,titulo) THEN
//				bien = 1
//				EXIT
//			END IF
//			
//			ubihis.orden  = f_almparam_numorden(codigo_empresa,ubihis.almacen,Year(Today()))
//			mov_entrada = f_almparam_nummov(codigo_empresa,ubihis.almacen,Year(Today()))
//			ubihis.nummov = mov_entrada
//			IF NOT f_actualiza_nummov(ubihis.empresa,ubihis.almacen,Year(Today()),mov_entrada) THEN
//				bien = 1
//				EXIT
//			END IF
//			IF NOT f_insert_almlinubicahis(ubihis) THEN  
//				bien = 1
//				EXIT
//			END IF
//		
//			IF NOT f_actualiza_numorden(ubihis.empresa,ubihis.almacen,Year(Today()),ubihis.nummov) THEN
//				bien = 1
//				EXIT
//			END IF
//		
//			// ............... PARA EL DE UBICACIONES
//			ubi.almacen    = ubihis.almacen
//			ubi.zona       = ubihis.zona
//			ubi.fila       = ubihis.fila
//			ubi.altura     = ubihis.altura
//			ubi.lote       = ubihis.lote
//			ubi.envase     = ubihis.envase
//			ubi.existencias= ubihis.cantidade
//			ubi.ubicacion  = ubihis.ubicacion
//			
//			// Si ya hay existencias del artículo procesado en las 
//			// ubicaciones seleccionadas, se actualiza la tabla. 
//			//En caso contrario, se inserta
//			
//			ubi.linea = f_ult_linea_ubi_art(ubi.empresa,ubi.ubicacion,ubi.articulo,ubi.lote)		
//		
//			IF (ubi.linea>0) THEN
//				// Actualización
//				UPDATE almlinubica  
//				SET existencias = (existencias + :ubi.existencias)
//				WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//						( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//						( almlinubica.linea     = :ubi.linea) 
//				USING SQLCA;
//				IF SQLCA.SQLCode<>0 THEN  
//					bien = 1
//					EXIT
//				END IF
//			ELSE
//				// Inserción
//				ubi.linea = (f_ult_linea_ubi(ubi.empresa,ubi.ubicacion)) + 1
//				IF NOT f_insert_almlinubica(ubi) THEN
//					bien = 1
//					EXIT
//				END IF
//			END IF
//		
//			f_desbloquear(tabla,seleccion,titulo)
//		
//			/*******************************************************/
//			/*	PROCESO 3: SALIDA DE LAS TABLAS DE UBICACIONES						  */
//			/*******************************************************/
//			ubihis.almacen = "2"
//			ubihis.zona    = "1"
//			ubihis.fila    = 1
//			ubihis.altura  = 1
//			ubihis.lote    = ""
//			ubihis.cantidade = 0
//			ubihis.cantidads = cantidad
//			ubihis.ubicacion = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
//									 ubihis.fila,ubihis.altura)
//			ubihis.tipomov   = '108'
//				
//			// Cálculo del número de orden 
//			titulo        =  'Confirmacion Albaranes'
//			longitudes    =  Len(Trim(codigo_empresa))
//			criterio[1]   =  Trim(codigo_empresa)+ Space(20-longitudes)
//			anyo          =  Year(Today())
//			longitudes    =  Len(Trim(String(anyo_exis)))
//			criterio[2]   =  Trim(String(anyo)) + Space(20-longitudes)
//			longitudes    =  Len(Trim(ubihis.almacen))
//			criterio[3]   =  Trim(ubihis.almacen) + Space(20-longitudes)
//			seleccion     =  criterio[1]+criterio[2]+criterio[3]
//			tabla         =  "almparam"
//			
//			IF f_bloquear(tabla,seleccion,titulo) THEN
//				bien = 1
//				EXIT
//			END IF
//			
//			mov_salida    = f_almparam_nummov(codigo_empresa,ubihis.almacen,Year(Today()))
//			ubihis.orden  = f_almparam_numorden(codigo_empresa,ubihis.almacen,Year(Today()))
//			
//			ubihis.nummov = mov_salida
//			
//			IF NOT f_insert_almlinubicahis(ubihis) THEN  
//				bien = 1
//				EXIT
//			END IF
//			
//			IF NOT f_actualiza_numorden(ubihis.empresa,ubihis.almacen,Year(Today()),ubihis.nummov) THEN
//				bien = 1
//				EXIT
//			END IF
//			IF NOT f_actualiza_nummov(ubihis.empresa,ubihis.almacen,Year(Today()),mov_salida) THEN
//				bien = 1
//				EXIT
//			END IF
//			
//		
//			// ............... PARA EL DE UBICACIONES
//			ubi.almacen    = ubihis.almacen
//			ubi.zona       = ubihis.zona
//			ubi.fila       = ubihis.fila
//			ubi.altura     = ubihis.altura
//			ubi.lote       = ubihis.lote
//			ubi.existencias= ubihis.cantidads
//			ubi.ubicacion  = ubihis.ubicacion
//				
//			// Si ya hay existencias del artículo procesado en las ubicaciones
//			// seleccionadas, se actualiza la tabla. En caso contrario, se inserta
//			Dec ls_exist
//			
//			// Miro si hay existencias de ese artículo
//			ubi.linea = f_ult_linea_ubi_art(ubi.empresa,ubi.ubicacion,ubi.articulo,ubi.lote)		
//				
//			IF ubi.linea > 0 THEN
//				// Actualización
//				SELECT almlinubica.existencias into :ls_exist FROM almlinubica
//				WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//						( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//						( almlinubica.linea     = :ubi.linea) 
//						USING SQLCA;
//				IF ubi.existencias < ls_exist THEN
//					UPDATE almlinubica  
//					SET existencias = (existencias - :ubi.existencias)
//					WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//									( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//									( almlinubica.linea     = :ubi.linea) 
//							USING SQLCA;
//				
//						IF SQLCA.SQLCode<>0 THEN  
//							bien = 1
//							EXIT
//						END IF
//				ELSE
//					// borro la línea
//					DELETE FROM almlinubica  
//						WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//								( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//								( almlinubica.linea     = :ubi.linea )
//						USING SQLCA;
//					IF SQLCA.SQLCode<>0 THEN  
//						bien = 1
//						EXIT
//					END IF
//				END IF
//			END IF
//			f_desbloquear(tabla,seleccion,titulo)
//		
//			/******************************************************/
//			/*	PROCESO 3: ENTRADA EN TABLA DE MOVIMIENTOS                		  */
//			/******************************************************/
//		
//			// Cargar estructura de datos para la tabla de movimientos
//			mov.usuario    = nombre_usuario
//			mov.empresa    = ubihis.empresa
//			mov.almacen    = "1"
//			mov.anyo			= anyo_exis
//			mov.nummov     = mov_entrada
//			mov.articulo   = ubihis.articulo
//			mov.familia    = ubihis.familia
//			mov.tipo_unidad= ubihis.tipo_unidad
//			mov.referencia = ubihis.referencia
//			mov.f_alta     = ubihis.f_alta       
//			mov.origen     = "3"
//			mov.fechmov    = ubihis.fecha
//			mov.tipomov    = ubihis.tipomov
//			mov.cantidade  = cantidad
//			mov.cantidads  = 0
//			mov.precio     = 0
//			mov.tipo_materia  = ubihis.tipo_materia
//			SetNull(mov.codtercero)
//			mov.numdoc        = albaran
//			mov.situacion     = "N"
//			mov.antexist      = 0
//			mov.observaciones = ""
//			mov.lote          = ""
//			SetNull(mov.punteado)
//			
//			IF NOT f_insert_almmovhis(mov) Then
//				bien = 1
//				EXIT
//			END IF
//		
//			/***************************************************/
//			/*	PROCESO 4: SALIDA EN TABLA DE MOVIMIENTOS                		  */
//			/***************************************************/
//		
//			mov.cantidads  = cantidad
//			mov.cantidade  = 0
//			mov.tipomov    = "108"
//			mov.nummov     = mov_salida
//			mov.almacen    = "2"
//			
//			IF NOT f_insert_almmovhis(mov) Then
//				MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
//				bien = 1
//				EXIT
//			END IF
//		END IF
//			// Peticion de las ubicaciones y nº de lote
//			// Abre la ventana de Petición de Ubicaciones para cada Línea
//		
////			string retorno
////			str_parametros lstr_param
////			lstr_param.i_nargumentos=9
////			lstr_param.s_argumentos[1] = "w_confirmacion_alb"
////			lstr_param.s_argumentos[2] = proceso
////			lstr_param.s_argumentos[3] = anyo_st
////			lstr_param.s_argumentos[4] = albaran
////			lstr_param.s_argumentos[5] = linea_alb
////			lstr_param.s_argumentos[6] = mprima
////			lstr_param.s_argumentos[7] = provee
////			lstr_param.s_argumentos[8] = String(date(fecha))
////			lstr_param.s_argumentos[9] = Trim(String(cantidad))
////			lstr_param.s_argumentos[10]= unidad
////			
////			OpenWithParm(w_ventana_ubicacion,lstr_param) 
////			retorno = Message.StringParm
////			IF retorno = "N" THEN 
////				bien = bien + 1
////				EXIT
////			END IF
////		END IF
//	END IF
//NEXT
//
//if bien <> 0 then 
//	messagebox(string(bien)+" error/es en albarán","El proceso no se actualiza ~n~r"+sqlca.sqlerrtext)
//	rollback;
//else
//	commit;
//end if
//dw_1.Retrieve(codigo_empresa,uo_proveedor.em_codigo.text)
//
end event

type cb_2 from commandbutton within w_confirmacion_alb_con_alm
integer x = 2546
integer y = 1388
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

event clicked;close(w_confirmacion_alb)


end event

type em_anyo2 from u_em_campo within w_confirmacion_alb_con_alm
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

type em_alb from u_em_campo within w_confirmacion_alb_con_alm
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 265
integer y = 204
integer width = 219
integer taborder = 40
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

type uo_mprima from u_em_campo_2 within w_confirmacion_alb_con_alm
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 558
integer y = 204
integer width = 969
integer taborder = 50
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

type gb_2 from groupbox within w_confirmacion_alb_con_alm
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

type st_8 from statictext within w_confirmacion_alb_con_alm
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

type gb_3 from groupbox within w_confirmacion_alb_con_alm
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

type cb_3 from commandbutton within w_confirmacion_alb_con_alm
integer x = 2546
integer y = 160
integer width = 315
integer height = 144
integer taborder = 60
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

type gb_7 from groupbox within w_confirmacion_alb_con_alm
integer x = 2533
integer y = 288
integer width = 343
integer height = 992
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_6 from groupbox within w_confirmacion_alb_con_alm
integer x = 2533
integer y = 1252
integer width = 343
integer height = 236
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_1 from statictext within w_confirmacion_alb_con_alm
integer x = 2574
integer y = 352
integer width = 265
integer height = 908
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Las lineas marcadas como ~'OK~' pasan al almacén, las marcadas como ~'Rechazada~' quedan como pedidos pendientes y las ~'N/C~' no se procesan."
boolean focusrectangle = false
end type

type dw_1 from u_datawindow within w_confirmacion_alb_con_alm
integer x = 9
integer y = 340
integer width = 2501
integer height = 1136
string dataobject = "dw_confirmacion_alb"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;dw_1.AcceptText()
f_control(row)
if isnull(dwo) then return

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
	CASE "boton_nc"
		pulsado=dwo.border
		if pulsado='6' then
			dwo.border='5'
			dw_1.Object.boton_bueno.border='6'
			dw_1.object.boton_malo.border='6'
			lineas=dw_1.rowcount()
			for i=1 to lineas
				dw_1.setitem(i,"comlinalb_libre",'N')
			next
		end if

END CHOOSE

end event

event itemchanged;

dec r,newcanti,difcanti,newimpor
String alba,linea,anyo_st,situ
Integer newlin
str_comlinalb lin

dw_1.AcceptText()

IF dw_1.GetColumnName()= "comlinalb_cantidad" Then
	r       = dw_1.GetRow()
	anyo_st = Trim(dw_1.GetItemString(r,"comlinalb_anyo"))
	alba    = Trim(dw_1.GetItemString(r,"comlinalb_albaran"))
	linea   = Trim(dw_1.GetItemString(r,"comlinalb_linea"))
	situ    = Trim(dw_1.GetItemString(r,"comlinalb_libre"))
	
			//LEO LINEA PINCHADA PARA SABER LA CANTIDAD QUE TENIA
	lin = f_leer_comlinalb(codigo_empresa,Trim(anyo_st),Trim(alba),Trim(linea))
	lin.empresa = codigo_empresa
	lin.anyo    = Trim(anyo_st)
	lin.albaran = Trim(alba)
	lin.linea   = Trim(linea)
	newcanti = dw_1.GetItemNumber(r,"comlinalb_cantidad")
	difcanti = lin.cantidad - newcanti
	IF difcanti < 1 THEN
		MessageBox("Modificacion de Cantidad","La cantidad no confirmada es "+String(difcanti,"#####"))
		dw_1.SetItem(r,"comlinalb_cantidad",lin.cantidad)
		RETURN
	ELSE
					// Grabo la linea modificada y luego una linea con la 
					// cantidad que queda
		newimpor = newcanti * lin.precio
		UPDATE comlinalb SET comlinalb.cantidad = :newcanti,
									comlinalb.importe  = :newimpor
		WHERE comlinalb.empresa = :codigo_empresa
		AND   comlinalb.anyo    = :lin.anyo
		AND   comlinalb.albaran = :lin.albaran
		AND   comlinalb.linea   = :lin.linea ;
		
		lin.cantidad = difcanti
		lin.importe  = lin.cantidad * lin.precio
		lin.situacion = "N"
		
		IF not(f_insert_comlinalb(lin)) THEN
			dw_1.SetItem(r,"comlinalb_cantidad",lin.cantidad)
			ROLLBACK;
		ELSE
			COMMIT;
		END IF
	END IF
	
END IF
end event

event retrieveend;call super::retrieveend;long i
FOR i=1 TO rowcount
	dw_1.setitem(i,"comlinalb_libre","N")
NEXT

end event

event key;call super::key;f_control(GetRow())
end event

