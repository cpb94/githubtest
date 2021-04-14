$PBExportHeader$w_int_promalb.srw
forward
global type w_int_promalb from w_int_con_empresa
end type
type uo_cliente from u_em_campo_2 within w_int_promalb
end type
type pb_1 from upb_salir within w_int_promalb
end type
type dw_listado from datawindow within w_int_promalb
end type
type dw_detalle from datawindow within w_int_promalb
end type
type dw_marcar from datawindow within w_int_promalb
end type
type dw_pallets from datawindow within w_int_promalb
end type
type cb_procesar from u_boton within w_int_promalb
end type
type dw_proceso2 from datawindow within w_int_promalb
end type
type dw_albaranes from datawindow within w_int_promalb
end type
type em_fecha from u_em_campo within w_int_promalb
end type
type ssss from statictext within w_int_promalb
end type
type st_conpromped1 from statictext within w_int_promalb
end type
type dw_pedidos from datawindow within w_int_promalb
end type
type ddlb_1 from dropdownlistbox within w_int_promalb
end type
type dw_rep from datawindow within w_int_promalb
end type
type dw_listado_sin_paneles from datawindow within w_int_promalb
end type
end forward

global type w_int_promalb from w_int_con_empresa
integer width = 2935
integer height = 1640
uo_cliente uo_cliente
pb_1 pb_1
dw_listado dw_listado
dw_detalle dw_detalle
dw_marcar dw_marcar
dw_pallets dw_pallets
cb_procesar cb_procesar
dw_proceso2 dw_proceso2
dw_albaranes dw_albaranes
em_fecha em_fecha
ssss ssss
st_conpromped1 st_conpromped1
dw_pedidos dw_pedidos
ddlb_1 ddlb_1
dw_rep dw_rep
dw_listado_sin_paneles dw_listado_sin_paneles
end type
global w_int_promalb w_int_promalb

type variables
String bloqueado
Dec{0} var_albaran,var_anyo_albaran
DateTime var_falbaran
String reposicion,exp_cargar,calculo_expositor,tipo_cli
end variables

forward prototypes
public function boolean f_bloquear ()
public subroutine f_desmarcar_pedido (integer var_anyo, integer var_pedido)
public function boolean f_grabar_albaran (string arg_empresa, decimal arg_anyo, decimal arg_pedido)
public function boolean f_servir_pedido (string arg_empresa, decimal arg_anyo, decimal arg_pedido)
public function boolean f_servir_linea_pedido (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea, decimal arg_cantidad)
public function boolean f_copiar_detalle_linea_pedido (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea, decimal arg_linea_destino)
public function boolean f_copiar_detalle_linea_albaran (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea, decimal arg_linea_albaran)
public function boolean f_servir_pallets_pedido (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_orden)
public subroutine f_imprimir ()
public function boolean f_actualizar_reposicion (string arg_empresa, decimal arg_anyo, decimal arg_pedido)
public subroutine f_marcar_pedido (integer var_anyo, decimal var_pedido)
end prototypes

public function boolean f_bloquear ();IF bloqueado = "S" Then Return TRUE
Dec{0} longitudes

 titulo        =  w_int_promalb.title
 longitudes    =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitudes)
 longitudes      =  len(trim(uo_cliente.em_codigo.text))
 criterio[2]   =  trim(uo_cliente.em_codigo.text)+space(20-longitudes)
 seleccion     =  criterio[1]+criterio[2]
 tabla         =  "Generación albaranes promocion"
 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
   COMMIT Using SQLCA; //Solucion nivel insolacion
	bloqueado = "S"
   RETURN TRUE
ELSE
	bloqueado = "N"
	RETURN FALSE
END IF
end function

public subroutine f_desmarcar_pedido (integer var_anyo, integer var_pedido);Integer registro,registros,reg
integer linea


For registro = 1 To dw_detalle.RowCount()
	linea  =  dw_detalle.getItemNumber(registro,"linea")
   reg =dw_marcar.find(" anyo = " + String(var_anyo) + " and pedido= " + &
        String(var_pedido) + " and linea= " + String(linea),&
		  1,dw_marcar.RowCount()) 
  if reg <> 0 then
	 dw_marcar.DeleteRow(reg)
  END IF
Next

For registro = 1 To dw_pallets.RowCount()
	linea  =  dw_pallets.getItemNumber(registro,"orden")
   reg =dw_marcar.find(" anyo = " + String(var_anyo) + " and pedido= " + &
        String(var_pedido) + " and orden= " + &
      String(linea),1,dw_marcar.RowCount()) 
  if reg <> 0 then
	 dw_marcar.DeleteRow(reg)
  END IF
Next

dw_detalle.Retrieve(codigo_empresa,var_anyo,var_pedido)
dw_pallets.Retrieve(codigo_empresa,var_anyo,var_pedido)
end subroutine

public function boolean f_grabar_albaran (string arg_empresa, decimal arg_anyo, decimal arg_pedido);Integer bien
bien = 0
str_promped ped
str_promalb alb


  SELECT promped.empresa,   
         promped.anyo,   
         promped.pedido,   
         promped.fpedido,   
         promped.fentrega,   
         promped.falta,   
         promped.cliente,   
         promped.flistado,   
         promped.observaciones,   
         promped.agente1,   
         promped.agente2,   
         promped.numpedcli,   
         promped.idioma,   
         promped.fbloqueo,   
         promped.transportista,   
         promped.serie,   
         promped.zona,   
         promped.envio,   
         promped.correspondencia,   
         promped.domiciliacion,   
         promped.forma_envio,   
         promped.cod_entrega,   
         promped.usuario,   
         promped.tipo_portes,   
         promped.periodo_fac,   
         promped.usuario_pedido,   
         promped.agente3,   
         promped.veces,   
         promped.tipo_expositor,   
         promped.expositor,   
         promped.tipo,   
         promped.pais,   
         promped.reposicion,   
         promped.situacion,   
         promped.control_libre  ,
         promped.peso_expositor ,
         promped.coste_expositor ,
         promped.venta_expositor,
			promped.clase_panel,
			promped.coste_manipulacion,
			promped.numserie,
			promped.exp_cargado,
			promped.tipo_cliente,
			promped.juego_de_piezas,
			promped.cajas
    INTO :ped.empresa,   
         :ped.anyo,   
         :ped.pedido,   
         :ped.fpedido,   
         :ped.fentrega,   
         :ped.falta,   
         :ped.cliente,   
         :ped.flistado,   
         :ped.observaciones,   
         :ped.agente1,   
         :ped.agente2,   
         :ped.numpedcli,   
         :ped.idioma,   
         :ped.fbloqueo,   
         :ped.transportista,   
         :ped.serie,   
         :ped.zona,   
         :ped.envio,   
         :ped.correspondencia,   
         :ped.domiciliacion,   
         :ped.forma_envio,   
         :ped.cod_entrega,   
         :ped.usuario,   
         :ped.tipo_portes,   
         :ped.periodo_fac,   
         :ped.usuario_pedido,   
         :ped.agente3,   
         :ped.veces,   
         :ped.tipo_expositor,   
         :ped.expositor,   
         :ped.tipo,   
         :ped.pais,   
         :ped.reposicion,   
         :ped.situacion,   
         :ped.control_libre,
         :ped.peso_expositor ,
         :ped.coste_expositor ,
         :ped.venta_expositor,
			:ped.clase_panel,
			:ped.coste_manipulacion,
			:ped.numserie,
			:ped.exp_cargado,
			:ped.tipo_cliente,
			:ped.juego_de_piezas,
			:ped.cajas

    FROM promped  
   WHERE ( promped.empresa = :arg_empresa )
	AND   ( promped.anyo = :arg_anyo )
	AND   ( promped.pedido = :arg_pedido )   ;
	IF SQLCA.SQLCODE <> 0 Then 
		f_mensaje("Error en datos",SQLCA.SQLERRTEXT)
		bien = 1
	END IF
	calculo_expositor = "N"
	IF ped.exp_cargado = "N" and exp_cargar= "S" then
		calculo_expositor = "S"
		  UPDATE promped  
     SET exp_cargado = "S"  
   WHERE ( promped.empresa = :arg_empresa ) AND  
         ( promped.anyo = :arg_anyo ) AND  
         ( promped.pedido = :arg_pedido )   ;
			IF SQLCA.SQLCODE <> 0 Then 
		f_mensaje("Error en datos",SQLCA.SQLERRTEXT)
		bien = 1
	END IF

	END IF
	reposicion = ped.reposicion
         alb.empresa        =  ped.empresa
         alb.anyo           =  var_anyo_albaran
         alb.albaran        =  var_albaran
         alb.falbaran       =  var_falbaran
         alb.fentrega       =  ped.fentrega
         alb.falta          =  ped.falta
         alb.cliente        =  ped.cliente
         alb.flistado       =  ped.flistado
         alb.observaciones  =  ped.observaciones
         alb.agente1        =  ped.agente1
         alb.agente2        =  ped.agente2
         alb.numpedcli      =  ped.numpedcli
         alb.idioma         =  ped.idioma
         alb.fbloqueo       =  ped.fbloqueo
         alb.transportista  =  ped.transportista
         alb.serie          =  ped.serie
         alb.zona           =  ped.zona
         alb.envio          =  ped.envio
         alb.correspondencia=  ped.correspondencia
         alb.domiciliacion  =  ped.domiciliacion
         alb.forma_envio    =  ped.forma_envio
         alb.cod_entrega    =  ped.cod_entrega
         alb.usuario        =  nombre_usuario
         alb.tipo_portes    =  ped.tipo_portes
         alb.periodo_fac    =  ped.periodo_fac
         alb.usuario_pedido=   ped.usuario_pedido
         alb.agente3        =  ped.agente3
         alb.veces          =  ped.veces
         alb.tipo_expositor =  ped.tipo_expositor
         alb.expositor      =  ped.expositor
         alb.tipo           =  ped.tipo
         alb.pais           =  ped.pais
         alb.reposicion     =  ped.reposicion
         alb.situacion      =  "S"
         alb.control_libre  =  ped.control_libre
         alb.anyo_pedido    =  ped.anyo
         alb.pedido         =  ped.pedido
         alb.f_pedido       =  ped.fpedido
         alb.f_entrega_real =  var_falbaran
			alb.exp_cargado    =	exp_cargar
			alb.tipo_cliente   =	ped.tipo_cliente
			alb.juego_de_piezas= ped.juego_de_piezas
			alb.cajas			 = ped.cajas
			IF alb.exp_cargado = "S" Then
	         alb.peso_expositor =  ped.peso_expositor 
   	      alb.coste_expositor=  ped.coste_expositor 
      	   alb.venta_expositor=  ped.venta_expositor 
			ELSE
			   alb.peso_expositor =  0 
   	      alb.coste_expositor=  0
      	   alb.venta_expositor=  0
			END IF
			alb.clase_panel=	ped.clase_panel
			alb.coste_manipulacion=	ped.coste_manipulacion
			alb.numserie=		ped.numserie
			IF Not f_insert_promalb(alb) Then
					f_mensaje("Error en datos",SQLCA.SQLERRTEXT)
					bien = 1
			END IF
			
IF bien = 0 Then 
	 Return TRUE
ELSE
	RETURN FALSE
END IF
	
end function

public function boolean f_servir_pedido (string arg_empresa, decimal arg_anyo, decimal arg_pedido);Integer bien,registro,registros
Dec{0}  var_anyo,var_pedido,var_linea,var_orden,var_cantidad
bien = 0
registros = dw_marcar.RowCount()
If registros = 0 Then Return FALSE
For registro = 1 To registros
	var_anyo      = dw_marcar.GetItemNumber(registro,"anyo")
	var_pedido    = dw_marcar.GetItemNumber(registro,"pedido")
	var_linea     = dw_marcar.GetItemNumber(registro,"linea")
	var_orden     = dw_marcar.GetItemNumber(registro,"orden")
	var_cantidad  = dw_marcar.GetItemNumber(registro,"cantidad")
	IF var_anyo = arg_anyo and var_pedido = arg_pedido Then
		IF IsNull(var_orden ) or var_orden = 0 Then
 		IF Not f_servir_linea_pedido(arg_empresa,arg_anyo,arg_pedido,var_linea,var_cantidad) Then 
			bien = 1
			f_mensaje("Error","servir linea de pedido")
		END IF
		Else
		IF Not f_servir_pallets_pedido(arg_empresa,arg_anyo,arg_pedido,var_orden) Then 
			bien = 1
			f_mensaje("Error","servir pallets pedidos")
		END IF
		END IF
	END IF
Next


IF bien = 0 Then 
	 Return TRUE
ELSE
	RETURN FALSE
END IF
	
end function

public function boolean f_servir_linea_pedido (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea, decimal arg_cantidad);Integer bien,registro,registros
Dec{0}  numero,cantidad_parcial,v_anyo_alb,v_albaran,v_linea_alb
str_promlinped lin
str_promlinalb linalb
bien = 0


SELECT   promlinped.empresa,promlinped.anyo,promlinped.pedido,   
         promlinped.linea,promlinped.cliente,promlinped.pais,   
         promlinped.tipo,promlinped.reposicion,   
         promlinped.panel,promlinped.cantidad,   
         promlinped.peso_panel,promlinped.coste_panel,   
         promlinped.venta_panel,promlinped.peso_material,   
         promlinped.coste_material,promlinped.venta_material,   
         promlinped.usuario,promlinped.usuario_pedido,   
         promlinped.situacion,promlinped.control_libre,   
         promlinped.f_pedido,promlinped.f_entrega,promlinped.agente1,   
         promlinped.agente2,promlinped.agente3,promlinped.tipo_expositor,   
         promlinped.expositor,promlinped.tipo_panel,promlinped.clase_panel,
			promlinped.coste_manipulacion,promlinped.numserie,
			promlinped.tipo_cliente
    INTO :lin.empresa,:lin.anyo,:lin.pedido,:lin.linea,:lin.cliente,   
         :lin.pais,:lin.tipo,:lin.reposicion,:lin.panel,:lin.cantidad,   
         :lin.peso_panel,:lin.coste_panel,:lin.venta_panel,
			:lin.peso_material,:lin.coste_material,:lin.venta_material,   
         :lin.usuario,:lin.usuario_pedido,:lin.situacion,
			:lin.control_libre,:lin.f_pedido,:lin.f_entrega,:lin.agente1,   
         :lin.agente2,:lin.agente3,:lin.tipo_expositor,:lin.expositor,
			:lin.tipo_panel,:lin.clase_panel,:lin.coste_manipulacion,
			:lin.numserie,:lin.tipo_cliente
    FROM  promlinped  
   WHERE (promlinped.empresa  = :arg_empresa )
	AND   (promlinped.anyo     = :arg_anyo )
	AND   (promlinped.pedido   = :arg_pedido )
	AND   (promlinped.linea    = :arg_linea )   ;
	IF SQLCA.SQLCODE <> 0 Then
		f_mensaje("Error en proceso","Pedido.."+ String(arg_anyo)+"-"+ String(arg_pedido) +"-"+ String(arg_linea))
		bien = 1
	END IF
	
	Select Max(linea) Into :linalb.linea From promlinalb
	Where  promlinalb.empresa   = :arg_empresa
	And    promlinalb.anyo      = :var_anyo_albaran
	And    promlinalb.albaran   = :var_albaran;
	IF IsNull(linalb.linea) Then linalb.linea = 0
	linalb.linea = linalb.linea + 1

	
         linalb.empresa        =   lin.empresa
         linalb.anyo           =   var_anyo_albaran
         linalb.albaran        =   var_albaran
         linalb.cliente        =   lin.cliente
         linalb.pais           =   lin.pais
         linalb.tipo           =   lin.tipo
         linalb.reposicion     =   lin.reposicion
         linalb.panel          =   lin.panel
         linalb.cantidad       =   arg_cantidad
         linalb.peso_panel     =   lin.peso_panel
         linalb.coste_panel    =   lin.coste_panel
         linalb.venta_panel    =   lin.venta_panel
         linalb.peso_material  =   lin.peso_material
         linalb.coste_material =   lin.coste_material
         linalb.venta_material =   lin.venta_material
         linalb.usuario        =   lin.usuario
         linalb.usuario_pedido =   lin.usuario_pedido
         linalb.situacion      =   "S"
         linalb.control_libre  =   lin.control_libre
         linalb.f_albaran      =   var_falbaran
         linalb.f_entrega      =   lin.f_entrega
         linalb.agente1        =   lin.agente1
         linalb.agente2        =   lin.agente2
         linalb.agente3        =   lin.agente3
         linalb.tipo_expositor =   lin.tipo_expositor
         linalb.expositor      =   lin.expositor
         linalb.f_entrega_real =   var_falbaran
         linalb.anyo_pedido    =   lin.anyo
         linalb.pedido         =   lin.pedido
         linalb.linea_pedido   =   lin.linea
         linalb.activo         =   "S"
         linalb.f_reposicion   =   var_falbaran
         SetNull(linalb.f_retirada)
         linalb.f_pedido       =   lin.f_pedido
			linalb.tipo_panel     =   lin.tipo_panel
			linalb.clase_panel=   lin.clase_panel
			linalb.coste_manipulacion =   lin.coste_manipulacion
			linalb.numserie =   lin.numserie
			linalb.tipo_cliente =   lin.tipo_cliente
			
			IF Not f_insert_promlinalb(linalb) Then
				f_mensaje("Error en proceso(Al grabar albaran)","Pedido.."+ String(arg_anyo)+"-"+ String(arg_pedido) +"-"+ String(arg_linea)+  "  " + sqlca.sqlerrtext)
				bien = 1
			END IF
  			  IF NOT f_copiar_detalle_linea_albaran(arg_empresa,arg_anyo,arg_pedido,arg_linea,linalb.linea) Then
				f_mensaje("Error en proceso(Al copiar detalle albaran)","Pedido.."+ String(arg_anyo)+"-"+ String(arg_pedido) +"-"+ String(arg_linea))
				bien = 1
			END IF

if lin.panel <> "18" and lin.panel <> "19"then
	IF lin.cantidad <> arg_cantidad then
		Select max(promlinped.linea) Into :numero From promlinped
		Where  promlinped.empresa   = :arg_empresa
		And    promlinped.anyo      = :arg_anyo
		And    promlinped.pedido    = :arg_pedido;
		If IsNull(numero) Then numero = 0
		numero = numero + 1
		cantidad_parcial = lin.cantidad - arg_cantidad
		INSERT INTO promlinped  
			(empresa,anyo,pedido,linea,cliente,pais,tipo,reposicion,panel,   
			 cantidad,peso_panel,coste_panel,venta_panel,peso_material,   
			 coste_material,venta_material,usuario,usuario_pedido,   
			 situacion,control_libre,f_pedido,f_entrega,agente1,   
			 agente2,agente3,tipo_expositor,expositor,tipo_panel,
			 clase_panel,coste_manipulacion,tipo_cliente)  
		VALUES (:lin.empresa,:lin.anyo,:lin.pedido,:numero,   
				  :lin.cliente,:lin.pais,:lin.tipo,:lin.reposicion,   
				  :lin.panel,:cantidad_parcial,:lin.peso_panel,   
				  :lin.coste_panel,:lin.venta_panel,:lin.peso_material,   
				  :lin.coste_material,:lin.venta_material,:lin.usuario,
				  :lin.usuario_pedido,:lin.situacion,   
				  :lin.control_libre,:lin.f_pedido,:lin.f_entrega,   
				  :lin.agente1,:lin.agente2,:lin.agente3,   
				  :lin.tipo_expositor,
				  :lin.expositor,
				  :lin.tipo_panel,
				  :lin.clase_panel,
				  :lin.coste_manipulacion,
				  :lin.tipo_cliente);
				  IF SQLCA.SQLCODE<> 0 Then
					f_mensaje("Error el grabar Pedido" , String(lin.pedido) + "/" + String(lin.linea))
					bien = 1
					END IF
				  IF NOT f_copiar_detalle_linea_pedido(arg_empresa,arg_anyo,arg_pedido,arg_linea,numero) Then
					bien = 1
					f_mensaje("Error Al copiar detalle pedido" , String(lin.pedido) + "/" + String(lin.linea))
					END IF
	
	END IF	
end if

 UPDATE promlinped  
 SET cantidad  = :arg_cantidad,   
     situacion = "S"
  WHERE  promlinped.empresa = :arg_empresa
  AND    promlinped.anyo    = :arg_anyo
  AND    promlinped.pedido  = :arg_pedido
  AND    promlinped.linea   = :arg_linea;
  IF SQLCA.SQLCODE <> 0 Then 
		f_mensaje("Error en datos ",SQLCA.SQLERRTEXT)
		bien = 1
  END IF
  IF reposicion = "S" Then
  IF Not f_actualizar_reposicion(arg_empresa,arg_anyo,arg_pedido) Then 
	bien = 1
   f_mensaje("Error Actualizar Reposicion Pedido" , String(lin.pedido) + "/" + String(lin.linea))
END IF
END IF
IF bien = 0 Then 
	 Return TRUE
ELSE
	RETURN FALSE
END IF
	
end function

public function boolean f_copiar_detalle_linea_pedido (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea, decimal arg_linea_destino);// Graba el detalle de una linea de pedido (panel-contenido) a otra
// linea de pedido

Integer bien,registros,registro
str_promlindetallped detall
bien  = 0



registros = dw_proceso2.Retrieve(arg_empresa,arg_anyo,arg_pedido,arg_linea)
IF registros = 0 Then Return FALSE
detall.orden=1
For  registro  =  1 To registros
  detall.empresa         =   dw_proceso2.GetItemString(registro,"empresa") 
  detall.anyo            =   dw_proceso2.GetItemNumber(registro,"anyo") 
  detall.pedido          =   dw_proceso2.GetItemNumber(registro,"pedido") 
  detall.linea           =   arg_linea_destino
  detall.orden           =   detall.orden +1 
  detall.panel           =   dw_proceso2.GetItemString(registro,"panel") 
  detall.articulo        =   dw_proceso2.GetItemString(registro,"articulo") 
  detall.calidad         =   dw_proceso2.GetItemString(registro,"calidad") 
  detall.montajeartcal   =   dw_proceso2.GetItemString(registro,"montajeartcal") 
  detall.piezas          =   dw_proceso2.GetItemNumber(registro,"piezas") 
  detall.usuario         =   nombre_usuario
  detall.usuario_pedido  =   dw_proceso2.GetItemString(registro,"usuario_pedido") 
  detall.observaciones   =   dw_proceso2.GetItemString(registro,"observaciones") 
  detall.peso            =   dw_proceso2.GetItemNumber(registro,"peso") 
  detall.coste           =   dw_proceso2.GetItemNumber(registro,"coste") 
  detall.venta           =   dw_proceso2.GetItemNumber(registro,"venta") 
  detall.pais           =   dw_proceso2.GetItemString(registro,"pais") 
  detall.cliente        =   dw_proceso2.GetItemString(registro,"cliente") 
  detall.tipo           =   dw_proceso2.GetItemString(registro,"tipo") 
  detall.reposicion     =   dw_proceso2.GetItemString(registro,"reposicion") 
  detall.situacion      =   dw_proceso2.GetItemString(registro,"situacion") 
  detall.f_pedido      =   dw_proceso2.GetItemDateTime(registro,"f_pedido") 
  detall.f_entrega      =   dw_proceso2.GetItemDateTime(registro,"f_entrega") 
  detall.agente1        =   dw_proceso2.GetItemString(registro,"agente1") 
  detall.agente2        =   dw_proceso2.GetItemString(registro,"agente2") 
  detall.agente3        =   dw_proceso2.GetItemString(registro,"agente3") 
  detall.tipo_expositor =   dw_proceso2.GetItemString(registro,"tipo_expositor") 
  detall.expositor      =   dw_proceso2.GetItemString(registro,"expositor")
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
				  expositor )  
	  VALUES ( :detall.empresa,   
				  :detall.anyo,   
				  :detall.pedido,   
				  :detall.linea,   
				  :detall.orden,   
				  :detall.panel,   
				  :detall.articulo,   
				  :detall.calidad,   
				  :detall.montajeartcal,   
				  :detall.piezas,   
				  :detall.usuario,   
				  :detall.usuario_pedido,   
				  :detall.observaciones,   
				  :detall.peso,   
				  :detall.coste,   
				  :detall.venta,   
				  :detall.pais,   
				  :detall.cliente,   
				  :detall.tipo,   
				  :detall.reposicion,   
				  :detall.situacion,   
				  :detall.f_pedido,   
				  :detall.f_entrega,   
				  :detall.agente1,   
				  :detall.agente2,   
				  :detall.agente3,   
				  :detall.tipo_expositor,   
				  :detall.expositor )  ;
	
	  
				  IF SQLCA.SQLCODE<> 0 Then bien = 1
			
Next


If bien = 0 Then
	  Return TRUE
Else
     Return FALSE
END IF
end function

public function boolean f_copiar_detalle_linea_albaran (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_linea, decimal arg_linea_albaran);// Graba el detalle de una linea de pedido (panel-contenido) a una
// linea de un albaran

Integer bien,registros,registro
str_promlindetallalb detallalb
bien  = 0



registros = dw_proceso2.Retrieve(arg_empresa,arg_anyo,arg_pedido,arg_linea)
IF registros = 0 Then 
//	f_mensaje("Posible error","Existe un panel sin lineas")
	Return TRUE
END IF
detallalb.orden=1
For  registro  =  1 To registros
  detallalb.empresa      =   dw_proceso2.GetItemString(registro,"empresa") 
  detallalb.anyo         =   var_anyo_albaran 
  detallalb.albaran      =   var_albaran
  detallalb.linea        =   arg_linea_albaran
  detallalb.orden        =   detallalb.orden +1 
  detallalb.panel        =   dw_proceso2.GetItemString(registro,"panel") 
  detallalb.articulo     =   dw_proceso2.GetItemString(registro,"articulo") 
  detallalb.calidad      =   dw_proceso2.GetItemString(registro,"calidad") 
  detallalb.montajeartcal=   dw_proceso2.GetItemString(registro,"montajeartcal") 
  detallalb.piezas       =   dw_proceso2.GetItemNumber(registro,"piezas") 
  detallalb.usuario         =   nombre_usuario
  detallalb.usuario_pedido  =   dw_proceso2.GetItemString(registro,"usuario_pedido") 
  detallalb.observaciones   =   dw_proceso2.GetItemString(registro,"observaciones") 
  detallalb.peso            =   dw_proceso2.GetItemNumber(registro,"peso") 
  detallalb.coste           =   dw_proceso2.GetItemNumber(registro,"coste") 
  detallalb.venta           =   dw_proceso2.GetItemNumber(registro,"venta") 
  detallalb.pais           =   dw_proceso2.GetItemString(registro,"pais") 
  detallalb.cliente        =   dw_proceso2.GetItemString(registro,"cliente") 
  detallalb.tipo           =   dw_proceso2.GetItemString(registro,"tipo") 
  detallalb.reposicion     =   dw_proceso2.GetItemString(registro,"reposicion") 
  detallalb.situacion      =   dw_proceso2.GetItemString(registro,"situacion") 
  detallalb.f_albaran      =   dw_proceso2.GetItemDateTime(registro,"f_pedido") 
  detallalb.f_entrega      =   dw_proceso2.GetItemDateTime(registro,"f_entrega") 
  detallalb.agente1        =   dw_proceso2.GetItemString(registro,"agente1") 
  detallalb.agente2        =   dw_proceso2.GetItemString(registro,"agente2") 
  detallalb.agente3        =   dw_proceso2.GetItemString(registro,"agente3") 
  detallalb.tipo_expositor =   dw_proceso2.GetItemString(registro,"tipo_expositor") 
  detallalb.expositor      =   dw_proceso2.GetItemString(registro,"expositor") 
  detallalb.f_entrega_real =   var_falbaran 
  detallalb.anyo_pedido    =   dw_proceso2.GetItemNumber(registro,"anyo") 
  detallalb.pedido         =   dw_proceso2.GetItemNumber(registro,"pedido") 
  detallalb.linea_pedido   =   dw_proceso2.GetItemNumber(registro,"linea") 
  detallalb.orden_pedido   =   dw_proceso2.GetItemNumber(registro,"orden") 
  detallalb.activo         =   "S" 
  detallalb.f_reposicion   = var_falbaran 
  SetNull( detallalb.f_retirada)
  detallalb.f_pedido  =   dw_proceso2.GetItemDateTime(registro,"f_pedido") 
  iF Not f_insert_promlindetallalb(detallalb) Then
		f_mensaje(SQLCA.SQLERRTEXT,"Pedido.."+ String(arg_anyo)+"-"+ String(arg_pedido) +"-"+ String(arg_linea))
		bien = 1
  END IF
Next


If bien = 0 Then
	  Return TRUE
Else
     Return FALSE
END IF
end function

public function boolean f_servir_pallets_pedido (string arg_empresa, decimal arg_anyo, decimal arg_pedido, decimal arg_orden);Integer bien
String albexp_empresa, albexp_almacen,   albexp_zona,   &
       albexp_tipo_pallets, albexp_observaciones, albexp_control_libre,   &
       albexp_situacion  
Datetime albexp_f_pedido
		 
Dec{0}   albexp_anyo_pedido,   albexp_pedido,   &
         albexp_orden,         albexp_fila,   &
         albexp_altura,        albexp_pallets,albexp_anyo,albexp_albaran,&
			albexp_orden_pedido

bien = 0
  albexp_anyo = var_anyo_albaran
  albexp_albaran = var_albaran
  albexp_f_pedido = f_fpedido_promped(arg_empresa,arg_anyo,arg_pedido)
  SELECT prompedexp.empresa,   
         prompedexp.anyo,   
         prompedexp.pedido,   
         prompedexp.orden,   
         prompedexp.almacen,   
         prompedexp.zona,   
         prompedexp.fila,   
         prompedexp.altura,   
         prompedexp.pallets,   
         prompedexp.tipo_pallets,   
         prompedexp.observaciones,   
         prompedexp.control_libre

    INTO :albexp_empresa,   
         :albexp_anyo_pedido,   
         :albexp_pedido,   
         :albexp_orden_pedido,   
         :albexp_almacen,   
         :albexp_zona,   
         :albexp_fila,   
         :albexp_altura,   
         :albexp_pallets,   
         :albexp_tipo_pallets,   
         :albexp_observaciones,   
         :albexp_control_libre
         
    FROM prompedexp  
   WHERE ( prompedexp.empresa = :arg_empresa ) AND  
         ( prompedexp.anyo    = :arg_anyo ) AND  
         ( prompedexp.pedido  = :arg_pedido ) AND  
         ( prompedexp.orden   = :arg_orden )   ;
			IF SQLCA.SQLCODE <> 0 Then bien = 1
			
			
albexp_situacion  = "S"
Select max(orden) Into :albexp_orden From promalbexp			
  WHERE (promalbexp.empresa = :arg_empresa ) AND  
        (promalbexp.anyo    = :var_anyo_albaran ) AND  
        (promalbexp.albaran  = :var_albaran );
		  
	  IF IsNull(albexp_orden) Then albexp_orden = 0
	  albexp_orden = albexp_orden + 1			
			

	  

  INSERT INTO promalbexp  
         ( empresa,   
           anyo,   
           albaran,   
           orden,   
           almacen,   
           zona,   
           fila,   
           altura,   
           pallets,   
           tipo_pallets,   
           observaciones,   
           control_libre,   
           situacion,   
           anyo_pedido,   
           pedido,   
           f_pedido,
			  orden_pedido)  
  VALUES ( :albexp_empresa,   
           :albexp_anyo,   
           :albexp_albaran,   
           :albexp_orden,   
           :albexp_almacen,   
           :albexp_zona,   
           :albexp_fila,   
           :albexp_altura,   
           :albexp_pallets,   
           :albexp_tipo_pallets,   
           :albexp_observaciones,   
           :albexp_control_libre,   
           :albexp_situacion,   
           :albexp_anyo_pedido,   
           :albexp_pedido,   
           :albexp_f_pedido,
           :albexp_orden_pedido)  ;

IF SQLCA.SQLCODE<> 0 Then bien = 1       

  UPDATE prompedexp  
     SET situacion = "S"  
   WHERE ( prompedexp.empresa = :arg_empresa ) AND  
         ( prompedexp.anyo = :arg_anyo ) AND  
         ( prompedexp.pedido = :arg_pedido ) AND  
         ( prompedexp.orden = :arg_orden )   ;

			
						IF SQLCA.SQLCODE <> 0 Then bien = 1




IF bien = 0 Then
	Return TRUE
ELse
	Return FALSE
End if
end function

public subroutine f_imprimir ();Dec{0} ar_albaran,reg,regtot
regtot = dw_albaranes.RowCount()

For reg = 1 To regtot
	ar_albaran = dw_albaranes.GetItemNumber(reg,"albaran")
	if f_paneles_expositor(codigo_empresa,f_expositor_promseries(codigo_empresa,f_numserie_promalb(codigo_empresa,var_anyo_albaran,ar_albaran))) then
		IF dw_listado.retrieve(codigo_empresa,var_anyo_albaran,ar_albaran) <> 0 Then
			dw_listado.Modify("datawindow.print.copies = 1")
			dw_listado.print()
		END IF
	else
		IF dw_listado_sin_paneles.retrieve(codigo_empresa,var_anyo_albaran,ar_albaran) <> 0 Then
			dw_listado_sin_paneles.Modify("datawindow.print.copies = 1")
			dw_listado_sin_paneles.print()
		END IF		
	end if
Next
dw_albaranes.Reset()
end subroutine

public function boolean f_actualizar_reposicion (string arg_empresa, decimal arg_anyo, decimal arg_pedido);Dec  arg_linea,bi,reg,r,v_anyo_alb,v_albaran,v_linea_alb,v_orden  
string var_expositor,sel
datastore nueva_reposicion
bi = 0

select expositor into :var_expositor
from promped
where empresa = :arg_empresa
and anyo = :arg_anyo
and pedido = :arg_pedido;

if f_paneles_expositor(codigo_empresa,var_expositor) then
	/////////////reposicion antigua\\\\\\\\\\\\\\\\\\\\\
	reg = dw_rep.Retrieve(arg_empresa,arg_anyo,arg_pedido)
	IF reg = 0 Then 	Return TRUE
	Update prompedreposicion
	Set    prompedreposicion.anyo_alb_rep = :var_anyo_albaran,
			 prompedreposicion.alb_rep      = :var_albaran
		WHERE ( prompedreposicion.empresa = :arg_empresa ) AND  
				( prompedreposicion.anyo    = :arg_anyo) AND  
				( prompedreposicion.pedido  = :arg_pedido) ;
				 IF SQLCA.SQLCODE <> 0 Then 
						f_mensaje("Error en datos la linea no existe en reposicion",SQLCA.SQLERRTEXT)
						bi = 1
				  END IF
	For r = 1 To reg
		arg_linea = dw_rep.GetItemNumber(r,"linea")
	SELECT prompedreposicion.anyo_alb,prompedreposicion.albaran,   
				prompedreposicion.linea_alb  
		INTO :v_anyo_alb,:v_albaran,:v_linea_alb  
		 FROM prompedreposicion  
		WHERE ( prompedreposicion.empresa = :arg_empresa ) AND  
				( prompedreposicion.anyo    = :arg_anyo ) AND  
				( prompedreposicion.pedido  = :arg_pedido ) AND  
				( prompedreposicion.linea   = :arg_linea )   ;
				  IF SQLCA.SQLCODE <> 0 Then 
						f_mensaje("Error en datos la linea no existe en reposicion",SQLCA.SQLERRTEXT)
						bi = 1
				  END IF
								  
		UPDATE promlinalb  
		  SET activo = 'N'  
		WHERE  promlinalb.empresa = :arg_empresa AND  
				 promlinalb.anyo    = :v_anyo_alb AND  
				 promlinalb.albaran = :v_albaran AND  
				 promlinalb.linea   = :v_linea_alb;
	IF SQLCA.SQLCODE <> 0 Then 
			f_mensaje("Error en datos",SQLCA.SQLERRTEXT)
			bi = 1
	END IF
	Next
else
	/////////////reposicion nueva\\\\\\\\\\\\\\\\\\\\\
	sel = "select linea from prompedlinreposicion "+&
			"where empresa = '"+arg_empresa+"' "+&
			"and anyo = "+string(arg_anyo)+" "+&
			"and pedido ="+string(arg_pedido)+" "
			
	nueva_reposicion = f_cargar_cursor(sel)
	reg = nueva_reposicion.rowcount()
	IF reg = 0 Then 	Return TRUE
	Update prompedlinreposicion
	Set    prompedlinreposicion.anyo_alb_rep = :var_anyo_albaran,
			 prompedlinreposicion.alb_rep      = :var_albaran
	WHERE ( prompedlinreposicion.empresa = :arg_empresa ) AND  
			( prompedlinreposicion.anyo    = :arg_anyo) AND  
			( prompedlinreposicion.pedido  = :arg_pedido) ;
   IF SQLCA.SQLCODE <> 0 Then 
		f_mensaje("Error en datos la linea no existe en reposicion",SQLCA.SQLERRTEXT)
		bi = 1
   END IF
	For r = 1 To reg
		arg_linea = nueva_reposicion.GetItemNumber(r,"linea")
		SELECT prompedlinreposicion.anyo_alb,prompedlinreposicion.albaran,   
				prompedlinreposicion.linea_alb,prompedlinreposicion.orden  
		INTO :v_anyo_alb,:v_albaran,:v_linea_alb,:v_orden  
		FROM prompedlinreposicion  
		WHERE ( prompedlinreposicion.empresa = :arg_empresa ) AND  
				( prompedlinreposicion.anyo    = :arg_anyo ) AND  
				( prompedlinreposicion.pedido  = :arg_pedido ) AND  
				( prompedlinreposicion.linea   = :arg_linea )   ;
	  	IF SQLCA.SQLCODE <> 0 Then 
			f_mensaje("Error en datos la linea no existe en reposicion",SQLCA.SQLERRTEXT)
			bi = 1
	  	END IF
								  
		UPDATE promlindetallalb  
		  SET activo = 'N'  
		WHERE  promlindetallalb.empresa = :arg_empresa AND  
				 promlindetallalb.anyo    = :v_anyo_alb AND  
				 promlindetallalb.albaran = :v_albaran AND  
				 promlindetallalb.linea   = :v_linea_alb and
				 promlindetallalb.orden   = :v_orden ;
	IF SQLCA.SQLCODE <> 0 Then 
			f_mensaje("Error en datos",SQLCA.SQLERRTEXT)
			bi = 1
	END IF
	Next
	
end if
IF bi = 0 Then
	Return True
Else
	Return False
End If
end function

public subroutine f_marcar_pedido (integer var_anyo, decimal var_pedido);Integer registro,registros,reg
Dec{0} linea,var_cantidad

reg = dw_marcar.Rowcount()

For registro = 1 To dw_detalle.RowCount()
	linea  =  dw_detalle.getItemNumber(registro,"linea")
	reg    =  reg +1
	dw_marcar.InsertRow(reg)
   var_cantidad = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"cantidad")
   dw_marcar.SetItem(reg,"anyo",var_anyo)	
   dw_marcar.SetItem(reg,"pedido",var_pedido)	
   dw_marcar.SetItem(reg,"linea",linea)	
   dw_marcar.SetItem(reg,"cantidad",var_cantidad)	
Next

For registro = 1 To dw_pallets.RowCount()
	linea  =  dw_pallets.getItemNumber(registro,"orden")
	reg    =  reg +1
	dw_marcar.InsertRow(reg)
   dw_marcar.SetItem(reg,"anyo",var_anyo)	
   dw_marcar.SetItem(reg,"pedido",var_pedido)	
   dw_marcar.SetItem(reg,"orden",linea)	
Next

dw_detalle.Retrieve(codigo_empresa,var_anyo,var_pedido)
dw_pallets.Retrieve(codigo_empresa,var_anyo,var_pedido)
end subroutine

on w_int_promalb.create
int iCurrent
call super::create
this.uo_cliente=create uo_cliente
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.dw_detalle=create dw_detalle
this.dw_marcar=create dw_marcar
this.dw_pallets=create dw_pallets
this.cb_procesar=create cb_procesar
this.dw_proceso2=create dw_proceso2
this.dw_albaranes=create dw_albaranes
this.em_fecha=create em_fecha
this.ssss=create ssss
this.st_conpromped1=create st_conpromped1
this.dw_pedidos=create dw_pedidos
this.ddlb_1=create ddlb_1
this.dw_rep=create dw_rep
this.dw_listado_sin_paneles=create dw_listado_sin_paneles
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cliente
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.dw_marcar
this.Control[iCurrent+6]=this.dw_pallets
this.Control[iCurrent+7]=this.cb_procesar
this.Control[iCurrent+8]=this.dw_proceso2
this.Control[iCurrent+9]=this.dw_albaranes
this.Control[iCurrent+10]=this.em_fecha
this.Control[iCurrent+11]=this.ssss
this.Control[iCurrent+12]=this.st_conpromped1
this.Control[iCurrent+13]=this.dw_pedidos
this.Control[iCurrent+14]=this.ddlb_1
this.Control[iCurrent+15]=this.dw_rep
this.Control[iCurrent+16]=this.dw_listado_sin_paneles
end on

on w_int_promalb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_cliente)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.dw_detalle)
destroy(this.dw_marcar)
destroy(this.dw_pallets)
destroy(this.cb_procesar)
destroy(this.dw_proceso2)
destroy(this.dw_albaranes)
destroy(this.em_fecha)
destroy(this.ssss)
destroy(this.st_conpromped1)
destroy(this.dw_pedidos)
destroy(this.ddlb_1)
destroy(this.dw_rep)
destroy(this.dw_listado_sin_paneles)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Asignación Albaranes de promoción"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

ddlb_1.text = "Si"
em_fecha.text= String(Today())
dw_pedidos.SetTransObject(SQLCA)
dw_rep.SetTransObject(SQLCA)
dw_pedidos.SetRowFocusIndicator(Hand!)
dw_marcar.SetTransObject(SQLCA)

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_listado_sin_paneles.SetTransObject(SQLCA)
dw_albaranes.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_detalle.SetRowFocusIndicator(Hand!)

dw_pallets.SetTransObject(SQLCA)
dw_pallets.SetRowFocusIndicator(Hand!)

f_mascara_columna(dw_detalle,"cantidad","###,##0")
bloqueado = "N"
f_activar_campo(uo_cliente.em_campo)


end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_pedidos)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_pedidos)
end event

event ue_listar;// retieve
dw_report =dw_listado
Call Super::ue_listar
end event

event ue_f5;call super::ue_f5;cb_procesar.TriggerEvent(Clicked!)
end event

event close;call super::close;IF bloqueado = "S" Then
	f_desbloquear(tabla,seleccion,titulo) 
	bloqueado = "N"
	COMMIT;
END IF
end event

event activate;call super::activate;w_int_promalb = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_promalb
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_promalb
integer taborder = 70
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_promalb
integer y = 44
end type

type uo_cliente from u_em_campo_2 within w_int_promalb
integer x = 526
integer y = 156
integer width = 1193
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;if ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
   ue_datawindow ="dw_ayuda_clientes"
   ue_filtro = ""
Else
	ue_titulo = "Selección de no clientes"
   ue_datawindow ="dw_ayuda_vencliproforma"
   ue_filtro = ""
End if
ue_campo = This.em_campo
end event

event modificado;call super::modificado;IF bloqueado = "S" Then
	f_desbloquear(tabla,seleccion,titulo) 
	COMMIT ;
	bloqueado = "N"
END IF

if ddlb_1.text = "Si" then
	uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
Else
   uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)	
End if

tipo_cli ="N"
if ddlb_1.text = "Si" then tipo_cli = "S"

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_marcar.Reset()
dw_pedidos.Reset()
dw_detalle.Reset()
dw_pallets.Reset()

iF dw_pedidos.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo_cli) <> 0 tHEN
end if

end event

type pb_1 from upb_salir within w_int_promalb
integer x = 2715
integer y = 32
integer height = 112
integer taborder = 0
end type

type dw_listado from datawindow within w_int_promalb
boolean visible = false
integer x = 101
integer width = 114
integer height = 88
integer taborder = 120
boolean bringtotop = true
string dataobject = "report_list_promalbaranes"
boolean livescroll = true
end type

type dw_detalle from datawindow within w_int_promalb
integer x = 27
integer y = 892
integer width = 1545
integer height = 520
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_int_promalb2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;dw_detalle.AcceptText()
If row = 0 Then Return
IF This.GetItemNumber(row,"cantidad") >This.GetItemNumber(row,"ccantidad_ant") or This.GetItemNumber(row,"cantidad")<= 0 Then
	This.SetItem(row,"cantidad",This.GetItemNumber(row,"ccantidad_ant"))
	f_mensaje("Error en introduccion de datos","La cantidad ha de ser mayor a cero y no superior a la del pedido")
	return
END IF

String var_serie

If row = 0 Then return
Dec{0}  var_anyo,var_pedido,var_linea,ln,reg,var_cantidad
IF  This.GetItemString(row,"tipo") = "2" THen
	var_serie = This.GetItemString(row,"promlinped_numserie")
	IF var_serie = "" or IsNull(var_serie) Then
		f_mensaje("Este pedido no se puede asignar","No tiene el numero de serie")
		Return
	END IF
END IF
IF Not f_bloquear() Then RETURN

  var_anyo    = This.GetItemNumber(row,"anyo")
  var_pedido  = This.GetItemNumber(row,"pedido")
  var_linea   = This.GetItemNumber(row,"linea")
  
 ln = dw_marcar.find("anyo =" + String(var_anyo)+ "and pedido="+&
                 String(var_pedido)+ "and linea=" + String(var_linea),1,dw_marcar.RowCount()) 
If ln = 0 Then
   reg = dw_marcar.RowCount() +1
   dw_marcar.InsertRow(reg)  
   dw_marcar.SetItem(reg, "anyo"   ,var_anyo)
   dw_marcar.SetItem(reg, "pedido" ,var_pedido)
   dw_marcar.SetItem(reg, "linea"  ,var_linea)
	var_cantidad = This.GetItemNumber(row,"cantidad")
   dw_marcar.SetItem(reg, "cantidad"  ,var_cantidad)
   dw_detalle.SetItem(row,"control_libre","X")
ELSE
   dw_marcar.DeleteRow(ln)  
   dw_detalle.SetItem(row,"control_libre","")

END iF

 ln = dw_marcar.find("anyo =" + String(var_anyo)+ "and pedido="+&
                 String(var_pedido),1,dw_marcar.RowCount()) 
IF ln = 0 Then
	 dw_pedidos.SetItem(dw_pedidos.GetRow(),"control_libre","")
ELSE
	 dw_pedidos.SetItem(dw_pedidos.GetRow(),"control_libre","X")
END IF
dw_detalle.SetColumn("cantidad")
end event

event getfocus;This.BorderStyle=StyleLowered!

f_datawindow_border_entrada(This)
IF dw_pedidos.RowCount() = 0 Then Return
IF dw_pedidos.GetItemString(dw_pedidos.getRow(),"tipo") = "1" Then
	 dw_detalle.SetTabOrder("cantidad",10)
ELSE
		 dw_detalle.SetTabOrder("cantidad",0)
END IF
end event

event losefocus;This.BorderStyle=StyleRaised!
f_datawindow_border_salida(This)
end event

event retrieveend;Integer row
IF rowcount()=0  Then return
Dec{0}  var_anyo,var_pedido,var_linea,ln
For row = 1 To rowcount
 var_anyo    = This.GetItemNumber(row,"anyo")
 var_pedido  = This.GetItemNumber(row,"pedido")
 var_linea   = This.GetItemNumber(row,"linea")
ln= dw_marcar.find(" anyo = " + String(var_anyo) + " and pedido= " + &
   String(var_pedido) + " and linea= " + &
	String(var_linea),1,dw_marcar.RowCount())
If	ln <> 0 Then
   This.SetItem(row,"control_libre","X")      						
	This.SetItem(row,"cantidad",dw_marcar.getItemNumber(ln,"cantidad"))      						
ELSE
   This.SetItem(row,"control_libre","")      						
END IF
Next
end event

event itemchanged;String var_serie
dw_detalle.AcceptText()
If row = 0 Then return
Dec{0}  var_anyo,var_pedido,var_linea,ln,reg,var_cantidad
IF  This.GetItemString(row,"tipo") = "2" THen
	var_serie = This.GetItemString(row,"promlinped_numserie")
	IF var_serie = "" or IsNull(var_serie) Then
		f_mensaje("Este pedido no se puede asignar","No tiene el numero de serie")
		Return
	END IF
END IF
IF Not f_bloquear() Then RETURN
If row = 0 Then Return
  var_anyo    = This.GetItemNumber(row,"anyo")
  var_pedido  = This.GetItemNumber(row,"pedido")
  var_linea   = This.GetItemNumber(row,"linea")
  
 ln = dw_marcar.find("anyo =" + String(var_anyo)+ "and pedido="+&
                 String(var_pedido)+ "and linea=" + String(var_linea),1,dw_marcar.RowCount()) 
If ln <> 0 Then
   reg = ln
   dw_marcar.SetItem(reg, "anyo"   ,var_anyo)
   dw_marcar.SetItem(reg, "pedido" ,var_pedido)
   dw_marcar.SetItem(reg, "linea"  ,var_linea)
	var_cantidad = This.GetItemNumber(row,"cantidad")
   dw_marcar.SetItem(reg, "cantidad"  ,var_cantidad)
END iF

 ln = dw_marcar.find("anyo =" + String(var_anyo)+ "and pedido="+&
                 String(var_pedido),1,dw_marcar.RowCount()) 
IF ln = 0 Then
	 dw_pedidos.SetItem(dw_pedidos.GetRow(),"control_libre","")
ELSE
	 dw_pedidos.SetItem(dw_pedidos.GetRow(),"control_libre","X")
END IF
end event

type dw_marcar from datawindow within w_int_promalb
boolean visible = false
integer x = 370
integer width = 530
integer height = 72
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_int_promalb3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pallets from datawindow within w_int_promalb
integer x = 1573
integer y = 892
integer width = 1271
integer height = 520
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_int_promalb4"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Not f_bloquear() Then RETURN
If row = 0 Then return
Dec{0}  var_anyo,var_pedido,var_linea,ln,reg

If row = 0 Then Return
  var_anyo    = This.GetItemNumber(row,"anyo")
  var_pedido  = This.GetItemNumber(row,"pedido")
  var_linea   = This.GetItemNumber(row,"orden")
  
 ln = dw_marcar.find("anyo =" + String(var_anyo)+ "and pedido="+&
                 String(var_pedido)+ "and orden=" + String(var_linea),1,dw_marcar.RowCount()) 
If ln = 0 Then
   reg = dw_marcar.RowCount() +1
   dw_marcar.InsertRow(reg)  
   dw_marcar.SetItem(reg, "anyo"   ,var_anyo)
   dw_marcar.SetItem(reg, "pedido" ,var_pedido)
   dw_marcar.SetItem(reg, "orden"  ,var_linea)
   This.SetItem(row,"control_libre","X")
ELSE
   dw_marcar.DeleteRow(ln)  
   This.SetItem(row,"control_libre","")

END iF

 ln = dw_marcar.find("anyo =" + String(var_anyo)+ "and pedido="+&
                 String(var_pedido),1,dw_marcar.RowCount()) 
IF ln = 0 Then
  	    dw_pedidos.SetItem(dw_pedidos.GetRow(),"control_libre","")
ELSE
		 dw_pedidos.SetItem(dw_pedidos.GetRow(),"control_libre","X")
END IF
end event

event getfocus;This.BorderStyle=StyleLowered!
f_datawindow_border_entrada(This)
end event

event losefocus;This.BorderStyle=StyleRaised!
f_datawindow_border_salida(This)
end event

event retrieveend;Integer row
IF rowcount() = 0 Then Return
Dec{0}  var_anyo,var_pedido,var_linea

For row = 1 To rowcount()
 var_anyo    = This.GetItemNumber(row,"anyo")
 var_pedido  = This.GetItemNumber(row,"pedido")
 var_linea   = This.GetItemNumber(row,"orden")
IF dw_marcar.find(" anyo = " + String(var_anyo) + " and pedido= " + &
   String(var_pedido) + " and orden= " + &
	String(var_linea),1,dw_marcar.RowCount()) <> 0 Then
   This.SetItem(row,"control_libre","X")      						
ELSE
   This.SetItem(row,"control_libre","")      		
END IF
NEXT
end event

type cb_procesar from u_boton within w_int_promalb
integer x = 1728
integer y = 160
integer width = 361
integer height = 80
integer taborder = 0
string text = "F5 Procesar"
end type

event clicked;Integer regped,totregped,bien,numero
If dw_marcar.RowCOunt() = 0 Then
   f_mensaje("No Se puede procesar"," No hay lineas marcadas")
	Return
END IF

String impresora,cadena,impre
impre=dw_listado.Describe("Datawindow.Printer")
SELECT ven_usuimpre.impresora_preparacion
INTO :impresora  
FROM ven_usuimpre
Where empresa = :codigo_empresa
And   usuario = :nombre_usuario;
IF impre <> impresora Then
  MessageBox("Selecciona la impresora predeterminada","La impresora debe de ser" + impresora,Exclamation!,OK!,1)
  printSetup()
  Return
END IF

String criterio_dw,texto

Dec{0} var_anyo,var_pedido
criterio_dw = "control_libre = 'X' "
dw_pedidos.Setfilter(criterio_dw)
dw_detalle.Setfilter(criterio_dw)
dw_pallets.Setfilter(criterio_dw)
dw_pedidos.filter()
dw_detalle.filter()
dw_pallets.filter()
dw_pedidos.Setfilter("")
dw_detalle.Setfilter("")
dw_pallets.Setfilter("")
bien = 0
totregped =dw_pedidos.RowCOunt()
If totregped = 0 Then return
var_falbaran     = DateTime(Date(em_fecha.text))
var_anyo_albaran = Year(Date(em_fecha.text))

Select max(promalb.albaran) Into :var_albaran From promalb
Where  promalb.empresa   =  :codigo_empresa
And    promalb.anyo      =  :var_anyo_albaran;
If IsNull(var_albaran) Then var_albaran = 0
numero = dw_albaranes.RowCount()
IF IsNull(numero) Then numero =0

FOR regped = 1 To totregped
  var_albaran = var_albaran + 1
  numero = numero + 1
  dw_albaranes.InsertRow(numero)
  dw_albaranes.SetItem(numero ,"albaran",var_albaran)
  var_anyo    =  dw_pedidos.GetItemNumber(regped,"anyo")
  var_pedido  =  dw_pedidos.GetItemNumber(regped,"pedido")
  exp_cargar  =  dw_pedidos.GetItemString(regped,"exp_cargado")
  IF Not f_grabar_albaran(codigo_empresa,var_anyo,var_pedido) Then
	 texto = "Error en grabar albaran"
	 bien = 1
  END IF
  
  IF Not f_servir_pedido(codigo_empresa,var_anyo,var_pedido) then
	texto = "Error en servir pedidos"
	bien  = 1
  END IF
  
  IF Not f_calculo_promped(codigo_empresa,var_anyo,var_pedido) then
	texto = "Error en calculo pedido"
	bien  = 1
  END IF
  IF Not f_calculo_promalb(codigo_empresa,var_anyo,var_albaran) then
	texto = "Error en calculo albaran"
	bien  = 1
  END IF
  
  
  f_contador_procesos(regped,totregped)
Next
IF  bien = 0 Then
	COMMIT;
ELSE
	f_mensaje(texto," El proceso no se actualiza  " + SQLCA.SQLERRTEXT)
	ROLLBACK;
END IF

dw_marcar.Reset()
dw_pedidos.Reset()
dw_detalle.Reset()
dw_pallets.Reset()
if dw_pedidos.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo_cli) <> 0 tHEN
end if


impre=dw_listado.Describe("Datawindow.Printer")
SELECT ven_usuimpre.impresora_preparacion
INTO :impresora  
FROM ven_usuimpre
Where empresa = :codigo_empresa
And   usuario = :nombre_usuario;
IF impre <> impresora Then
  MessageBox("Selecciona la impresora predeterminada","La impresora debe de ser" + impresora,Exclamation!,OK!,1)
  printSetup()
ELse
  f_imprimir()
END IF





end event

type dw_proceso2 from datawindow within w_int_promalb
boolean visible = false
integer y = 4
integer width = 105
integer height = 88
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_proceso_promlindetallped"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_albaranes from datawindow within w_int_promalb
boolean visible = false
integer x = 2382
integer width = 494
integer height = 240
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_int_promalb5"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_fecha from u_em_campo within w_int_promalb
integer x = 2405
integer y = 156
integer width = 288
integer taborder = 0
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type ssss from statictext within w_int_promalb
integer x = 2181
integer y = 164
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_conpromped1 from statictext within w_int_promalb
integer x = 18
integer y = 160
integer width = 238
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_pedidos from datawindow within w_int_promalb
event clicked pbm_dwnlbuttonclk
integer x = 32
integer y = 256
integer width = 2816
integer height = 636
integer taborder = 40
string dataobject = "dw_int_promalb1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "proceso" Then
	String var_serie ,var_tipo
	If getRow() = 0 Then return
	var_serie = This.GetItemString(Getrow(),"numserie")
	var_tipo  = This.GetItemString(Getrow(),"tipo")
	if var_tipo = "2" then
	 IF var_serie = "" or IsNull(var_serie) Then
	 	f_mensaje("Este pedido no se puede asignar","No tiene el numero de serie")
		Return 
	 END IF
	END IF
	IF Not f_bloquear() Then RETURN
	Dec{0} var_anyo,var_pedido
	String var_carga
	var_anyo   = GetItemNumber(GetRow(),"anyo")
	var_pedido = GetItemNumber(GetRow(),"pedido")
	  SELECT promped.exp_cargado  
	    INTO :var_carga  
	    FROM promped  
	   WHERE ( promped.empresa = :codigo_empresa) AND  
	         ( promped.anyo    = :var_anyo)       AND  
	         ( promped.pedido  = :var_pedido);
	
 IF This.GetItemString(Getrow(),"control_libre")="X" Then
	 This.SetItem(Getrow(),"control_libre","")
 	 This.SetItem(Getrow(),"exp_cargado",var_carga)
	 f_desmarcar_pedido(This.GetItemNumber(Getrow(),"anyo"),This.GetItemNumber(Getrow(),"pedido"))
 ELSE
	 This.SetItem(Getrow(),"control_libre","X")
  	 This.SetItem(Getrow(),"exp_cargado","S")
	 f_marcar_pedido(This.GetItemNumber(Getrow(),"anyo"),This.GetItemNumber(Getrow(),"pedido"))
 END  IF
END IF
IF IsNull(row) Then row = 0
IF row = 0 Then Return
ScrollTorow(row)
SetRow(row)

end event

event rowfocuschanged;	IF dw_pedidos.GetRow() = 0 Then return
	dw_detalle.Retrieve(codigo_empresa,dw_pedidos.GetItemNumber(dw_pedidos.GetRow(),"anyo"),dw_pedidos.GetItemNumber(dw_pedidos.GetRow(),"pedido"))
	dw_pallets.Retrieve(codigo_empresa,dw_pedidos.GetItemNumber(dw_pedidos.GetRow(),"anyo"),dw_pedidos.GetItemNumber(dw_pedidos.GetRow(),"pedido"))

end event

event getfocus;f_datawindow_border_entrada(This)
This.BorderStyle=StyleLowered!
end event

event losefocus;This.BorderStyle=StyleRaised!
f_datawindow_border_salida(This)
end event

event itemchanged;IF GetRow() = 0 Then return
Dec{0} var_anyo,var_pedido
String var_carga
var_anyo = GetItemNumber(GetRow(),"anyo")
var_pedido = GetItemNumber(GetRow(),"pedido")
  SELECT promped.exp_cargado  
    INTO :var_carga  
    FROM promped  
   WHERE ( promped.empresa = :codigo_empresa) AND  
         ( promped.anyo    = :var_anyo)       AND  
         ( promped.pedido  = :var_pedido);

IF IsNull(var_carga) Then var_carga = "N"
IF var_carga = "S" Then SetItem(GetRow(),"exp_cargado","S")



end event

type ddlb_1 from dropdownlistbox within w_int_promalb
integer x = 274
integer y = 156
integer width = 247
integer height = 228
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type dw_rep from datawindow within w_int_promalb
boolean visible = false
integer x = 224
integer y = 8
integer width = 133
integer height = 84
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_proceso_prompedreposicion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_sin_paneles from datawindow within w_int_promalb
boolean visible = false
integer x = 965
integer y = 12
integer width = 114
integer height = 88
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_list_promalbaranes_sin_paneles"
boolean livescroll = true
end type

