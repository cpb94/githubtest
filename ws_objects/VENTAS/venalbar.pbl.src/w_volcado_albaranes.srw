$PBExportHeader$w_volcado_albaranes.srw
forward
global type w_volcado_albaranes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_volcado_albaranes
end type
type st_2 from statictext within w_volcado_albaranes
end type
type dw_listado from datawindow within w_volcado_albaranes
end type
type uo_cliente from u_em_campo_2 within w_volcado_albaranes
end type
type gb_1 from groupbox within w_volcado_albaranes
end type
type cb_continuar from commandbutton within w_volcado_albaranes
end type
type dw_detalle2 from u_datawindow_consultas within w_volcado_albaranes
end type
type st_3 from statictext within w_volcado_albaranes
end type
type em_porcentaje from u_em_campo within w_volcado_albaranes
end type
type st_4 from statictext within w_volcado_albaranes
end type
type dw_cabecera from u_datawindow_consultas within w_volcado_albaranes
end type
type dw_detalle from u_datawindow_consultas within w_volcado_albaranes
end type
type st_5 from statictext within w_volcado_albaranes
end type
type imprimir from dropdownpicturelistbox within w_volcado_albaranes
end type
end forward

global type w_volcado_albaranes from w_int_con_empresa
integer width = 2898
integer height = 1716
string title = "Volcado de albaranes"
pb_1 pb_1
st_2 st_2
dw_listado dw_listado
uo_cliente uo_cliente
gb_1 gb_1
cb_continuar cb_continuar
dw_detalle2 dw_detalle2
st_3 st_3
em_porcentaje em_porcentaje
st_4 st_4
dw_cabecera dw_cabecera
dw_detalle dw_detalle
st_5 st_5
imprimir imprimir
end type
global w_volcado_albaranes w_volcado_albaranes

type variables
Dec d = 1
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_detalle (integer reg)
public subroutine f_proceso ()
end prototypes

public subroutine f_control ();STring   cli1,cli2
dw_detalle.Reset()
IF Trim(uo_cliente.em_codigo.text) = "" Then
	cli1 = "."
	cli2 = "Z"
ELSE
	cli1 = 	uo_cliente.em_codigo.text
	cli2 = 	uo_cliente.em_codigo.text
END IF
dw_detalle.Retrieve(codigo_empresa,cli1,cli2)
dw_cabecera.Retrieve(codigo_empresa,cli1,cli2)



f_activar_campo(uo_cliente.em_campo)


end subroutine

public subroutine f_detalle (integer reg);Dec vcantidad,r
STring cadena,tipo_pallet,articulo,empresa,caja,tipolinea

IF reg = 0 Then Return
IF dw_detalle.RowCount() = 0 Then Return
dw_detalle2.Retrieve(codigo_empresa,dw_detalle.GetItemNumber(reg,"anyo"),dw_detalle.GetItemNumber(reg,"albaran"))
For r = 1 To dw_detalle2.RowCOunt()
			vcantidad    =  Dec(em_porcentaje.text) * dw_detalle2.GetItemNumber(r,"venlialb_cantidad") /100
			empresa      = dw_detalle2.GetItemSTring(r,"venlialb_empresa")
			articulo     = dw_detalle2.GetItemSTring(r,"venlialb_articulo")
			tipo_pallet  = dw_detalle2.GetItemSTring(r,"venlialb_tipo_pallet")
   		caja         = dw_detalle2.GetItemSTring(r,"venlialb_caja")
			tipolinea = dw_detalle2.GetItemSTring(r,"venlialb_tipolinea")
			IF f_unidad_articulo(empresa,articulo) = "1" tHEN
			   cadena=f_calculo_unidades_tipolin(empresa,articulo,tipo_pallet,caja,0,0,vcantidad,tipolinea)
				vcantidad    = Dec(Mid(cadena,19,9))
				
			Else
				vcantidad    =  Dec(String((Dec(em_porcentaje.text) * dw_detalle2.GetItemNumber(r,"venlialb_cantidad") /100),f_mascara_decimales(0)))
				
			End If
			IF vcantidad = dw_detalle2.GetItemNumber(r,"venlialb_cantidad") and Dec(em_porcentaje.text) <> 100 Then				vcantidad = 0
			dw_detalle2.SetItem(r,"ccantidad_volcado",vcantidad)
Next
end subroutine

public subroutine f_proceso ();IF Not f_bloquear_albaranes(w_volcado_albaranes.title) Then
string cadena, tipolinea
str_venalb2   alb
str_venlialb2 l
Dec  var_anyo,var_albaran,bien,r,var_linea,xcantidad,numero,v_linea
bien = 0

var_anyo = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"anyo")
var_albaran = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"albaran")

alb.albaran  =  var_albaran
Select Max(linea) Into :v_linea From venlialb2
Where  empresa = :codigo_empresa
And    anyo = :var_anyo
And    albaran = :var_albaran;
IF IsNull(v_linea) Then v_linea = 0

  SELECT venalb.empresa,venalb.anyo,venalb.falbaran,   
         venalb.fentrega,venalb.falta,venalb.cliente,venalb.flistado,   
         venalb.observaciones,venalb.codpago,venalb.agente1,   
         venalb.agente2,venalb.comision1,venalb.comision2,   
         venalb.comision11,venalb.comision22,venalb.dtopp,   
         venalb.dtoesp1,venalb.dtoesp2,venalb.dtoesp3,   
         venalb.dtoesp4,venalb.tipodto1,venalb.tipodto2,   
         venalb.tipodto3,venalb.tipodto4,venalb.explicaciondto1,   
         venalb.explicaciondto2,venalb.explicaciondto3,   
         venalb.explicaciondto4,venalb.tipoiva,venalb.iva,
			venalb.numpedcli,venalb.idioma,venalb.divisa,   
         venalb.cambio,venalb.tarifa,venalb.ftarifa,   
         venalb.fbloqueo,venalb.transportista,venalb.serie,   
         venalb.zona,venalb.envio,venalb.correspondencia,   
         venalb.domiciliacion,venalb.forma_envio,   
         venalb.cod_entrega,venalb.usuario,venalb.tipo_portes,   
         venalb.periodo_fac,venalb.peso,venalb.usuario_pedido,   
         venalb.agente3,venalb.comision31,venalb.comision32,   
         venalb.veces,venalb.textcomercial1,venalb.textcomercial2,   
         venalb.textaduanaesp1,venalb.textaduanaesp2,
			venalb.textaduanaext1,venalb.textaduanaext2,   
         venalb.textopie1,venalb.textopie2,venalb.condicion,   
         venalb.peso_neto,venalb.banco_de_cobro,venalb.porcentaje_aduana,   
         venalb.bruto,venalb.importe_dto,venalb.total_neto,venalb.calculo_dto,   
         venalb.anyo_pedido_origen,venalb.pedido_origen,venalb.fcarga,   
         venalb.agrupa,venalb.deposito,venalb.almacen_deposito,venalb.abono,
			venalb.calculo_dtoesp
    INTO :alb.empresa,:alb.anyo,:alb.falbaran,:alb.fentrega,   
         :alb.falta,:alb.cliente,:alb.flistado,:alb.observaciones,   
         :alb.codpago,:alb.agente1,:alb.agente2,:alb.comision1,   
         :alb.comision2,:alb.comision11,:alb.comision22,:alb.dtopp,   
         :alb.dtoesp,:alb.dtoesp2,:alb.dtoesp3,:alb.dtoesp4,   
         :alb.tipodto1,:alb.tipodto2,:alb.tipodto3,:alb.tipodto4,   
         :alb.explicaciondto1,:alb.explicaciondto2,:alb.explicaciondto3,   
         :alb.explicaciondto4,:alb.tipoiva,:alb.iva,:alb.numpedcli,   
         :alb.idioma,:alb.divisa,:alb.cambio,:alb.tarifa,:alb.ftarifa,   
         :alb.fbloqueo,:alb.transportista,:alb.serie,:alb.zona,   
         :alb.envio,:alb.correspondencia,:alb.domiciliacion,:alb.forma_envio,   
         :alb.cod_entrega,:alb.usuario,:alb.tipo_portes,:alb.periodo_fac,   
         :alb.peso,:alb.usuario_pedido, :alb.agente3,:alb.comision31,   
         :alb.comision32,:alb.veces,:alb.textcomercial1,:alb.textcomercial2,   
         :alb.textaduanaesp1,:alb.textaduanaesp2, :alb.textaduanaext1,   
         :alb.textaduanaext2,:alb.textopie1,:alb.textopie2,:alb.condicion,   
         :alb.peso_neto,:alb.banco_de_cobro,:alb.porcentaje_aduana,   
         :alb.bruto, :alb.importe_dto, :alb.total_neto,:alb.calculo_dto,   
         :alb.anyo_pedido_origen,:alb.pedido_origen,:alb.fcarga,   
         :alb.agrupa,:alb.deposito, :alb.almacen_deposito, :alb.abono,
			:alb.calculo_dtoesp
    FROM  venalb  
   WHERE  venalb.empresa = :codigo_empresa 
	AND    venalb.anyo    = :var_anyo
	AND    venalb.albaran = :var_albaran;
	iF SQLCA.SQLCODE <> 0 Then bien = 1
	
	dec numer
	Select count(*) Into :numer From venalb2
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    albaran = :var_albaran;

	alb.tipoiva = "2"
	alb.iva = 0
	alb.dtopp = 3

	if numer=0 then
		IF Not f_insertar_venalb2(alb) Then 
			bien = 1
			f_mensaje("Error insertar venalb2",sqlca.sqlerrtext)
		END IF
	End if
	
	For r = 1 To dw_detalle2.RowCOunt()
			IF dw_detalle2.GetItemString(r,"cmarca")= "S" Then
				var_linea = dw_detalle2.GetItemNumber(r,"venlialb_linea")
				
				  SELECT venlialb.empresa,venlialb.anyo,venlialb.albaran,
							venlialb.linea, venlialb.serie, venlialb.falbaran,   
							venlialb.fentrega,venlialb.cliente, venlialb.tipo_unidad,   
							venlialb.articulo,venlialb.familia, venlialb.formato,   
							venlialb.modelo,venlialb.calidad,venlialb.tono,
							venlialb.calibre,venlialb.precio,venlialb.precio_estand, 
							venlialb.cantidad,venlialb.pallets,venlialb.total_cajas,
							venlialb.cajas,venlialb.dtocomer,venlialb.dtoesp,
							venlialb.descripcion,venlialb.tipoiva,venlialb.iva,
							venlialb.linfab,venlialb.provincia,venlialb.pais,
							venlialb.zona,venlialb.tipolinea,venlialb.texto1,
							venlialb.texto2,venlialb.texto3,venlialb.texto4,
							venlialb.referencia,venlialb.montajeartcal,
							venlialb.situacion,venlialb.divisa,venlialb.metros_lineales,
							venlialb.peso,venlialb.falta,venlialb.usuario,
							venlialb.tipo_pallet,venlialb.caja,
							venlialb.importe,venlialb.descuento,
							venlialb.importedto,venlialb.clase,venlialb.sector,
							venlialb.agente1,venlialb.agente2,venlialb.agente3,
							venlialb.comision11,venlialb.comision12,venlialb.comision21,
							venlialb.comision22,venlialb.comision31,venlialb.comision32,   
							venlialb.deposito, venlialb.orden_preparacion,   
							venlialb.cantidad_prepa,venlialb.es_pico,venlialb.numero_pico,   
							venlialb.anyo_ent,venlialb.nummov_ent,venlialb.anyo_sal,   
							venlialb.nummov_sal,venlialb.fila_ent,venlialb.altura_ent,   
							venlialb.operario_prepa,venlialb.control_incremento,   
							venlialb.peso_neto,venlialb.precio_aduana,   
							venlialb.control_descuentos,venlialb.control_comisiones,   
							venlialb.importe_aduana,venlialb.bruto,venlialb.precio_neto,   
							venlialb.precio_aduana_neto,venlialb.descuento_aduana,   
							venlialb.neto,venlialb.impdtopp,venlialb.ref_cli,   
							venlialb.transportista,venlialb.almacen_ent,   
							venlialb.anyo_pedido_origen,venlialb.pedido_origen,   
							venlialb.fcarga,venlialb.almacen_deposito,   
							venlialb.ubicacion,venlialb.envio,
							venlialb.contenedor,venlialb.numpedcli,
							venlialb.agrupa_exp
			 INTO :l.empresa,:l.anyo,:l.albaran,:l.linea,:l.serie,   
					:l.falbaran,:l.fentrega,:l.cliente,:l.tipo_unidad,   
					:l.articulo,:l.familia,:l.formato,:l.modelo,:l.calidad,   
					:l.tono,:l.calibre,:l.precio,:l.precio_estand,:l.cantidad,   
					:l.pallets,:l.total_cajas,:l.cajas,:l.dtocomer,:l.dtoesp,   
					:l.descripcion,:l.tipoiva,:l.iva,:l.linfab,:l.provincia,   
					:l.pais,:l.zona,:l.tipolinea,:l.texto1,:l.texto2,:l.texto3,   
					:l.texto4,:l.referencia,:l.montajeartcal,:l.situacion,   
					:l.divisa,:l.metros_lineales,:l.peso,:l.falta,:l.usuario,   
					:l.tipo_pallet,:l.caja,:l.importe,:l.descuento,:l.importedto,   
					:l.clase,:l.sector,:l.agente1,:l.agente2,:l.agente3,   
					:l.comision11,:l.comision12,:l.comision21,:l.comision22,   
					:l.comision31,:l.comision32,:l.deposito,:l.orden_preparacion,   
					:l.cantidad_prepa,:l.es_pico,:l.numero_pico,   
					:l.anyo_ent,:l.nummov_ent,:l.anyo_sal,:l.nummov_sal,   
					:l.fila_ent,:l.altura_ent,:l.operario_prepa,:l.control_incremento,   
					:l.peso_neto,:l.precio_aduana,:l.control_descuentos,   
					:l.control_comisiones,:l.importe_aduana,:l.bruto,   
					:l.precio_neto,:l.precio_aduana_neto,:l.descuento_aduana,   
					:l.neto,:l.impdtopp,:l.ref_cli,:l.transportista,
					:l.almacen_ent,:l.anyo_pedido_origen,:l.pedido_origen,   
					:l.fcarga,:l.almacen_deposito,:l.ubicacion,:l.envio ,
					:l.contenedor,:l.numpedcli,:l.agrupa_exp
			 FROM venlialb  
			WHERE venlialb.empresa = :codigo_empresa
			AND  	venlialb.anyo    = :var_anyo
			AND   venlialb.albaran = :var_albaran 
			AND  	venlialb.linea   = :var_linea ;

					l.albaran = alb.albaran
					l.linea = r + v_linea
					xcantidad = l.cantidad
					l.cantidad =  dw_detalle2.GetItemNumber(r,"ccantidad_volcado")
		
					 cadena=f_calculo_unidades_tipolin(l.empresa,l.articulo,&
													 l.tipo_pallet,l.caja,0,0,l.cantidad,l.tipolinea)
															  
				 l.pallets     = Dec(Mid(cadena,1,6))
				 l.cajas       = Dec(Mid(cadena,7,6))
				 l.total_cajas = Dec(Mid(cadena,13,6))
				 l.cantidad    = Dec(Mid(cadena,19,9))
				 IF   l.cantidad   <> 0 Then
					IF Not f_insertar_venlialb2(l) Then
						bien = 1
						f_mensaje("Error insercion venlialb2",sqlca.sqlerrtext)
					END IF
					
					xcantidad = xcantidad - l.cantidad
					cadena=f_calculo_unidades_tipolin(l.empresa,l.articulo,l.tipo_pallet,l.caja,0,0,xcantidad,l.tipolinea)																  
					 l.pallets    = Dec(Mid(cadena,1,6))
					 l.cajas      = Dec(Mid(cadena,7,6))
					 l.total_cajas    = Dec(Mid(cadena,13,6))
					 l.cantidad   = Dec(Mid(cadena,19,9))
					 IF l.cantidad = 0 Then
							    Delete venlialb 
								 Where venlialb.empresa = :codigo_empresa
								 And   venlialb.anyo    = :var_anyo
								 And   venlialb.albaran = :var_albaran
								 And   venlialb.linea   = :var_linea;
								 IF SQLCA.SQLCODE <> 0 Then 
									bien = 1
									f_mensaje("Error modificar venlialb",sqlca.sqlerrtext)
								 END IF
					 ELSE
								 UPdate venlialb Set venlialb.pallets     = :l.pallets ,
															venlialb.cajas       = :l.cajas,
															venlialb.total_cajas = :l.total_cajas,
															venlialb.cantidad    = :l.cantidad
								 Where venlialb.empresa = :codigo_empresa
								 And   venlialb.anyo    = :var_anyo
								 And   venlialb.albaran = :var_albaran
								 And   venlialb.linea   = :var_linea;
								 IF SQLCA.SQLCODE <> 0 Then 
									bien = 1
									f_mensaje("Error modificar venlialb",sqlca.sqlerrtext)
								 END IF
									IF Not f_actualizar_linea_venalbaran(l.empresa,var_anyo,var_albaran,var_linea) Then 
										bien = 1
										f_mensaje("Error actualizar lineavenlialb",sqlca.sqlerrtext)
									END IF
					END IF
					IF Not f_actualizar_linea_venalbaran2(l.empresa,l.anyo,l.albaran,l.linea) Then 
						bien = 1
						f_mensaje("Error actualizar venlialb3",sqlca.sqlerrtext)
					END IF

				END IF				 
				
			END IF
			f_mensaje_proceso("Volcando Albaran "+String(l.linea),r,dw_detalle2.RowCOunt() )
	NEXT
	
	
	
	IF Not f_actualizar_venalbaran2(l.empresa,l.anyo,l.albaran) Then bien = 1
	numero = 0
	Select Count(*) Into :numero From venlialb
	Where  venlialb.empresa = :l.empresa
	And    venlialb.anyo    = :var_anyo
	And    venlialb.albaran = :var_albaran;
	IF ISNUll(numero) Then numero =0
	IF numero = 0 Then
		Delete From venalb
		Where  venalb.empresa = :l.empresa
		And    venalb.anyo    = :var_anyo
		And    venalb.albaran = :var_albaran;
		IF sqlca.sqlcode <> 0 Then bien = 1
	ELSE
		IF Not f_actualizar_venalbaran(l.empresa,var_anyo,var_albaran) Then bien = 1
	END IF
	
	IF bien = 1 Then
		ROLLBACK;
		f_mensaje("Error en base de datos","El proceso no se actualiza")
	ELSE
		COMMIT;
	END IF
	f_desbloquear_albaranes(w_volcado_albaranes.title)
	IF imprimir.text = "Si" Then
	str_parametros lstr_param
	 lstr_param.i_nargumentos    = 4
	 lstr_param.s_argumentos[2]="2"
	 lstr_param.s_argumentos[3]=String(var_anyo)
	 lstr_param.s_argumentos[4]=String(var_albaran)
	 OpenWithParm(w_lis_venalbaranes,lstr_param)
 	 lstr_param.i_nargumentos    = 5
	 lstr_param.s_argumentos[2]=String(alb.anyo)
	 lstr_param.s_argumentos[3]=String(alb.albaran)
	 lstr_param.s_argumentos[4]="2"
	 lstr_param.s_argumentos[5]="N"
	 lstr_param.s_argumentos[6]="S"
	 OpenWithParm(w_lis_venalbaranes_volcados,lstr_param)
END IF
END IF
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;IF d= 1 Then
	f_pagina_arriba(dw_detalle)
ELSE
	f_pagina_arriba(dw_detalle2)
END IF
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;IF d= 1 Then
	f_cursor_arriba(dw_detalle)
ELSE
	f_cursor_arriba(dw_detalle2)
END IF
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;IF d= 1 Then
	f_pagina_abajo(dw_detalle)
ELSE
	f_pagina_abajo(dw_detalle2)
END IF
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Volcado de albaranes"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_detalle2.SetTransObject(SQLCA)
dw_cabecera.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)
end event

on w_volcado_albaranes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.dw_listado=create dw_listado
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.cb_continuar=create cb_continuar
this.dw_detalle2=create dw_detalle2
this.st_3=create st_3
this.em_porcentaje=create em_porcentaje
this.st_4=create st_4
this.dw_cabecera=create dw_cabecera
this.dw_detalle=create dw_detalle
this.st_5=create st_5
this.imprimir=create imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_continuar
this.Control[iCurrent+7]=this.dw_detalle2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_porcentaje
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.dw_cabecera
this.Control[iCurrent+12]=this.dw_detalle
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.imprimir
end on

on w_volcado_albaranes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.dw_listado)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.cb_continuar)
destroy(this.dw_detalle2)
destroy(this.st_3)
destroy(this.em_porcentaje)
destroy(this.st_4)
destroy(this.dw_cabecera)
destroy(this.dw_detalle)
destroy(this.st_5)
destroy(this.imprimir)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;IF d= 1 Then
	f_cursor_abajo(dw_detalle)
ELSE
	f_cursor_abajo(dw_detalle2)
END IF
end event

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

event activate;call super::activate;w_volcado_albaranes = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_volcado_albaranes
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_volcado_albaranes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_volcado_albaranes
integer x = 9
integer width = 2642
integer height = 92
end type

type pb_1 from upb_salir within w_volcado_albaranes
integer x = 2720
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_volcado_albaranes
integer x = 18
integer y = 152
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_volcado_albaranes
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_albaranes_cliente"
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_volcado_albaranes
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 152
integer width = 1435
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;dw_detalle.reset()
dw_detalle2.reset()
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within w_volcado_albaranes
integer x = 9
integer y = 108
integer width = 2130
integer height = 140
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_continuar from commandbutton within w_volcado_albaranes
integer x = 1742
integer y = 156
integer width = 379
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
string text = "F5 Continuar"
end type

event clicked;f_control()

end event

type dw_detalle2 from u_datawindow_consultas within w_volcado_albaranes
event doubleclicked pbm_dwnlbuttondblclk
event getfocus pbm_dwnsetfocus
integer x = 1179
integer y = 272
integer width = 1641
integer height = 708
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_volcado_albaranes_ventas2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event getfocus;call super::getfocus;d = 2
end event

event clicked;call super::clicked;Dec r
IF f_objeto_datawindow(This) = "procesar" Then
	if MessageBox("! A v i s o ¡","Este proceso pasa las lineas seleccionadas, ¿Desea continuar?",Exclamation!, YesNo!,1)= 1 then
		f_proceso()
		cb_continuar.TriggerEvent(Clicked!)
   End if
END IF

IF f_objeto_datawindow(This) = "desmarcar" Then
	For r = 1 To dw_detalle2.RowCount()
		dw_detalle2.SetItem(r,"cmarca","N")
	Next
END IF

IF f_objeto_datawindow(This) = "marcar1" Then
	For r = 1 To dw_detalle2.RowCount()
		IF	dw_detalle2.GetItemString(r,"venlialb_tipo_unidad")= "1" Then	dw_detalle2.SetItem(r,"cmarca","S")
	Next
END IF
IF f_objeto_datawindow(This) = "marcar2" Then
	For r = 1 To dw_detalle2.RowCount()
		IF	dw_detalle2.GetItemString(r,"venlialb_tipo_unidad")= "0" Then	dw_detalle2.SetItem(r,"cmarca","S")
	Next
END IF
d = 1
//f_control()
end event

event itemfocuschanged;call super::itemfocuschanged;Dec vcantidad,r
String empresa,articulo,tipo_pallet,cadena,caja, tipolinea
Accepttext()
IF this.GetColumnNAme() = "ccantidad_volcado" Then
	r = dw_detalle2.GetRow()
   IF  dw_detalle2.GetItemSTring(r,"venlialb_tipo_unidad") = "1" Then
		vcantidad    = dw_detalle2.GetItemNumber(r,"ccantidad_volcado")
		empresa      = dw_detalle2.GetItemSTring(r,"venlialb_empresa")
		articulo     = dw_detalle2.GetItemSTring(r,"venlialb_articulo")
		tipo_pallet  = dw_detalle2.GetItemSTring(r,"venlialb_tipo_pallet")
		caja         = dw_detalle2.GetItemSTring(r,"venlialb_caja")
		tipolinea         = dw_detalle2.GetItemSTring(r,"venlialb_tipolinea")
		cadena=f_calculo_unidades_tipolin(empresa,articulo,tipo_pallet,caja,0,0,vcantidad,tipolinea)
		vcantidad    = Dec(Mid(cadena,19,9))
	else
		vcantidad    = DEC(STring(dw_detalle2.GetItemNumber(r,"ccantidad_volcado"),f_mascara_decimales(0)))
	END IF
		dw_detalle2.SetItem(r,"ccantidad_volcado",vcantidad)
		dw_detalle2.SETFocus()
		dw_detalle2.SETRow(r)
		dw_detalle2.SETColumn("ccantidad_volcado")
	END IF

end event

type st_3 from statictext within w_volcado_albaranes
integer x = 2235
integer y = 116
integer width = 270
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Volcado:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_porcentaje from u_em_campo within w_volcado_albaranes
integer x = 2523
integer y = 104
integer width = 142
integer height = 72
integer taborder = 10
string text = "50"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##0"
string displaydata = "4ð"
end type

event modificado;call super::modificado;Dec r
STring empresa,articulo,tipo_pallet,cadena,caja, tipolinea
Dec vcantidad
IF dw_detalle2.RowCOunt()= 0  Then Return
For r = 1 To dw_detalle2.RowCOunt()
			vcantidad    =  Dec(em_porcentaje.text) * dw_detalle2.GetItemNumber(r,"venlialb_cantidad") /100
			empresa      = dw_detalle2.GetItemSTring(r,"venlialb_empresa")
			articulo     = dw_detalle2.GetItemSTring(r,"venlialb_articulo")
			tipo_pallet  = dw_detalle2.GetItemSTring(r,"venlialb_tipo_pallet")
			caja         = dw_detalle2.GetItemSTring(r,"venlialb_caja")
			tipolinea         = dw_detalle2.GetItemSTring(r,"venlialb_tipolinea")
		   cadena=f_calculo_unidades_tipolin(empresa,articulo,tipo_pallet,caja,0,0,vcantidad, tipolinea)
			vcantidad    = Dec(Mid(cadena,19,9))
			dw_detalle2.SetItem(r,"ccantidad_volcado",vcantidad)
Next
end event

type st_4 from statictext within w_volcado_albaranes
integer x = 2670
integer y = 108
integer width = 46
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_cabecera from u_datawindow_consultas within w_volcado_albaranes
event doubleclicked pbm_dwnlbuttondblclk
event getfocus pbm_dwnsetfocus
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
integer x = 238
integer y = 976
integer width = 2409
integer height = 448
integer taborder = 20
string dataobject = "dw_anulacion_albaranes_ventas3"
boolean vscrollbar = true
boolean resizable = true
end type

event getfocus;call super::getfocus;d = 3
end event

event clicked;call super::clicked;IF f_objeto_datawindow(This) = "imprimir" Then
	str_parametros lstr_param
	lstr_param.i_nargumentos    = 5
	lstr_param.s_argumentos[2]=String(dw_cabecera.GetItemNumber(dw_cabecera.GetRow(),"venalb2_anyo"))
	lstr_param.s_argumentos[3]=String(dw_cabecera.GetItemNumber(dw_cabecera.GetRow(),"venalb2_albaran"))
	lstr_param.s_argumentos[4]="1"
	lstr_param.s_argumentos[5]="N"
	lstr_param.s_argumentos[6]="S"
	OpenWithParm(w_lis_venalbaranes_volcados,lstr_param)
END IF

end event

type dw_detalle from u_datawindow_consultas within w_volcado_albaranes
integer y = 272
integer width = 1179
integer height = 708
integer taborder = 30
string dataobject = "dw_volcado_albaranes_ventas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event getfocus;call super::getfocus;d = 1
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_venalb,lstr_param) 
End If
end event

event rowfocuschanged;call super::rowfocuschanged;f_detalle(currentrow)
end event

event retrieveend;call super::retrieveend;IF dw_detalle.RowCount() <> 0 Then f_detalle(1)
end event

type st_5 from statictext within w_volcado_albaranes
integer x = 2235
integer y = 188
integer width = 279
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Imprimir:"
alignment alignment = right!
boolean focusrectangle = false
end type

type imprimir from dropdownpicturelistbox within w_volcado_albaranes
integer x = 2523
integer y = 176
integer width = 247
integer height = 236
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Si"
boolean vscrollbar = true
string item[] = {"Si","No"}
integer itempictureindex[] = {1,1}
long picturemaskcolor = 553648127
end type

