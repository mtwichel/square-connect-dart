import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:square_connect/square_connect.dart';

part 'square_api_client.g.dart';

@RestApi()
abstract class SquareApiClient {
  factory SquareApiClient({
    required String accessToken,
    String baseUrl = 'https://connect.squareup.com',
    String? apiVersion,
  }) =>
      _SquareApiClient(
        Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: <String, dynamic>{
              'Authorization': 'Bearer $accessToken',
              if (apiVersion != null) 'Square-Version': apiVersion,
            },
            contentType: 'application/json',
          ),
        ),
      );

  @GET('/v2/locations')
  Future<ListLocationsResponse> listLocations();

  @GET('/v2/locations/{locationId}')
  Future<RetrieveLocationResponse> retrieveLocation(@Path() String locationId);

  @POST('/v2/locations')
  Future<CreateLocationResponse> createLocation(
    @Body() CreateLocationRequest input,
  );

  @PUT('/v2/locations/{locationId}')
  Future<UpdateLocationResponse> updateLocation(
    @Path() String locationId,
    @Body() UpdateLocationRequest input,
  );

  @POST('/oauth2/token')
  Future<ObtainTokenResponse> obtainToken(@Body() ObtainTokenRequest request);

  @POST('/oauth2/revoke')
  Future<RevokeTokenResponse> revokeToken(
    @Body() RevokeTokenRequest request,
    @Header('Authorization') String applicationSecret,
  );

  @GET('/v2/merchants/{merchantId}')
  Future<RetrieveMerchantResponse> retrieveMerchant(@Path() String merchantId);

  @GET('/v2/merchants')
  Future<ListMerchantsResponse> listMerchants(@Query('cursor') int? cursor);

  @GET('/v2/catalog/list')
  Future<ListCatalogResponse> listCatalog({
    @Query('cursor') String? cursor,
    @Query('types') String? types,
    @Query('catalog_version') int? catalogVersion,
  });

  @GET('/v2/catalog/object/{objectId}')
  Future<RetrieveCatalogObjectResponse> retrieveCatalogObject({
    @Path() required String objectId,
    @Query('include_related_objects') bool? includeRelatedObjects,
    @Query('catalog_version') int? catalogVersion,
  });

  @POST('/v2/catalog/batch-retrieve')
  Future<BatchRetrieveCatalogObjectsResponse> batchRetrieveCatalogObjects({
    @Body()
        required BatchRetrieveCatalogObjectsRequest
            batchRetrieveCatalogObjectsRequest,
  });

  @POST('/v2/catalog/search')
  Future<ListCatalogResponse> searchCatalog(
    @Body() SearchCatalogRequest searchCatalogRequest,
  );

  @GET('/v2/orders/{orderId}')
  Future<RetrieveOrderResponse> retrieveOrder(
    @Path() String orderId,
  );

  @POST('/v2/orders')
  Future<CreateOrderResponse> createOrder(
    @Body() CreateOrderRequest createOrderRequest,
  );

  @PUT('/v2/orders/{orderId}')
  Future<UpdateOrderResponse> updateOrder(
    @Path() String orderId,
    @Body() UpdateOrderRequest updateOrderRequest,
  );

  @POST('/v2/orders/{orderId}/pay')
  Future<PayOrderResponse> payOrder(
    @Path() String orderId,
    @Body() PayOrderRequest payOrderRequest,
  );

  @POST('/v2/orders/calculate')
  Future<CalculateOrderResponse> calculateOrder(
    @Body() CalculateOrderRequest calculateOrderResponse,
  );

  @POST('/v2/payments')
  Future<CreatePaymentResponse> createPayment(
    @Body() CreatePaymentRequest createPaymentRequest,
  );

  // Customers API
  @GET('/v2/customers')
  Future<ListCustomersResponse> listCustomers(
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
    @Query('sort_field') CustomerSortField? sortField,
    @Query('sort_order') SortOrder? sortOrder,
  );

  @POST('/v2/customers')
  Future<CreateCustomerResponse> createCustomer(
    @Body() CreateCustomerRequest createCustomerRequest,
  );

  @POST('/v2/customers/search')
  Future<SearchCustomersResponse> searchCustomers(
    @Body() SearchCustomersRequest searchCustomersRequest,
  );

  @DELETE('/v2/customers/{customerId}')
  Future<DeleteCustomerResponse> deleteCustomer(
    @Path() String customerId,
  );

  @GET('/v2/customers/{customerId}')
  Future<RetrieveCustomerResponse> retrieveCustomer(
    @Path() String customerId,
  );

  @PUT('/v2/customers/{customerId}')
  Future<UpdateCustomerResponse> updateCustomer(
    @Path() String customerId,
    @Body() UpdateCustomerRequest request,
  );

  @POST('/v2/locations/{locationId}/checkouts')
  Future<CreateCheckoutResponse> createCheckout(
    @Path() String locationId,
    @Body() CreateCheckoutRequest request,
  );

  @GET('/v2/online-checkout/payment-links')
  Future<ListPaymentResponse> listPaymentLinks({
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
  });

  @POST('/v2/online-checkout/payment-links')
  Future<CreatePaymentLinkResponse> createPaymentLink({
    @Body() required CreatePaymentLinkRequest request,
  });

  @GET('/v2/cards')
  Future<ListCardsResponse> listCards({
    @Query('cursor') String? cursor,
    @Query('customer_id') String? customerId,
    @Query('include_disabled') bool? includeDisabled,
    @Query('reference_id') String? referenceId,
    @Query('sort_order') String? sortOrder,
  });

  @POST('/v2/cards')
  Future<CreateCardResponse> createCard(
    @Body() CreateCardRequest request,
  );

  @GET('/v2/cards/{cardId}')
  Future<RetrieveCardResponse> retrieveCard({
    @Path() required String cardId,
  });

  @POST('/v2/cards/{cardId}/disable')
  Future<DisableCardResponse> disableCard({
    @Path() required String cardId,
  });

  @POST('/v2/loyalty/accounts')
  Future<CreateLoyaltyAccountResponse> createLoyaltyAccount({
    @Body() required CreateLoyaltyAccountRequest request,
  });

  @POST('/v2/loyalty/accounts/search')
  Future<SearchLoyaltyAccountsResponse> searchLoyaltyAccounts({
    @Body() required SearchLoyaltyAccountsRequest request,
  });

  @GET('/v2/loyalty/accounts/{accountId}')
  Future<RetrieveLoyaltyAccountResponse> retrieveLoyaltyAccount({
    @Path() required String accountId,
  });

  @POST('/v2/loyalty/accounts/{accountId}/accumulate')
  Future<AccumulateLoyaltyPointsResponse> accumulateLoyaltyPoints({
    @Body() required AccumulateLoyaltyPointsRequest request,
    @Path() required String accountId,
  });

  @POST('/v2/loyalty/accounts/{accountId}/adjust')
  Future<AdjustLoyaltyPointsResponse> adjustLoyaltyPoints({
    @Body() required AdjustLoyaltyPointsRequest request,
    @Path() required String accountId,
  });

  @POST('/v2/loyalty/events/search')
  Future<SearchLoyaltyEventsResponse> searchLoyaltyEvents({
    @Body() required SearchLoyaltyEventsRequest request,
  });

  @GET('/v2/loyalty/programs/{programId}')
  Future<RetrieveLoyaltyProgramResponse> retrieveLoyaltyProgram({
    @Path() required String programId,
  });

  @POST('/v2/loyalty/rewards/{rewardId}/redeem')
  Future<RedeemLoyaltyRewardResponse> redeemLoyaltyReward({
    @Path() required String rewardId,
    @Body() required RedeemLoyaltyRewardRequest request,
  });

  @POST('/v2/loyalty/rewards')
  Future<CreateLoyaltyRewardResponse> createLoyaltyReward({
    @Body() required CreateLoyaltyRewardRequest request,
  });

  @DELETE('/v2/loyalty/rewards/{rewardId}')
  Future<DeleteLoyaltyReward> deleteLoyaltyReward({
    @Path() required String rewardId,
  });

  @GET('/v2/loyalty/rewards/{rewardId}')
  Future<RetrieveLoyaltyRewardResponse> retrieveLoyaltyReward({
    @Path() required String rewardId,
  });

  @POST('/v2/loyalty/programs/{programId}/calculate')
  Future<CalculateLoyaltyPointsResponse> calculateLoyaltyPoints({
    @Path() required String programId,
    @Body() required CalculateLoyaltyPointsRequest request,
  });

  /// Creates a subscription to a subscription plan by a customer.
  ///
  /// If you provide a card on file in the request, Square charges the card
  /// for the subscription. Otherwise, Square bills an invoice to the
  /// customer's email address. The subscription starts immediately, unless
  /// the request includes the optional start_date. Each individual
  /// subscription is associated with a particular location.
  @POST('/v2/subscriptions')
  Future<CreateSubscriptionRequest> createSubscription({
    @Body() required CreateSubscriptionRequest request,
  });

  /// Searches for subscriptions.
  ///
  /// Results are ordered chronologically by subscription creation date. If
  /// the request specifies more than one location ID, the endpoint orders the
  /// result by location ID, and then by creation date within each location.
  /// If no locations are given in the query, all locations are searched.
  ///
  /// You can also optionally specify customer_ids to search by customer.
  /// If left unset, all customers associated with the specified locations a
  /// re returned. If the request specifies customer IDs, the endpoint orders
  /// results first by location, within location by customer ID, and within
  /// customer by subscription creation date.
  @POST('/v2/subscriptions/search')
  Future<SearchSubscriptionsResponse> searchSubscriptions({
    @Body() required SearchSubscriptionsRequest request,
  });

  /// Retrieves a subscription.
  @GET('v2/subscriptions/{subscriptionId')
  Future<RetrieveSubscriptionResponse> retrieveSubscription({
    @Path() required String subscriptionId,
    @Query('include') String? include,
  });

  /// Updates a subscription.SquareApiClient
  ///
  /// You can set, modify, and clear the subscription field values.
  @PUT('/v2/subscriptions/{subscriptionId}')
  Future<UpdateSubscriptionResponse> updateSubscription({
    @Path() required String subscriptionId,
    @Body() required UpdateSubscriptionRequest request,
  });

  /// Deletes a scheduled action for a subscription.
  @DELETE('/v2/subscriptions/{subscriptionId}/actions{actionId}')
  Future<DeleteSubscriptionActionResponse> deleteSubscriptionAction({
    @Path() required String subscriptionId,
    @Path() required String actionId,
  });

  /// Schedules a `CANCEL` action to cancel an active subscription by setting
  /// the `canceled_date` field to the end of the active billing period and
  /// changing the subscription status from ACTIVE to CANCELED after this date.
  @POST('/v2/subscriptions/{subscriptionId}/cancel')
  Future<CancelSubscriptionResponse> cancelSubscription({
    @Path() required String subscriptionId,
  });

  /// Lists all events for a specific subscription.
  @GET('/v2/subscriptions/{subscriptionId}/events')
  Future<ListSubscriptionEventsResponse> listSubscriptionEvents({
    @Path() required String subscriptionId,
    @Query('cursor') String? cursor,
    @Query('limit') String? limit,
  });

  /// Schedules a `PAUSE` action to pause an active subscription.
  @POST('/v2/subscriptions/{subscriptionId}/pause')
  Future<PauseSubscriptionResponse> pauseSubscription({
    @Path() required String subscriptionId,
    @Body() required PauseSubscriptionRequest request,
  });

  /// Schedules a `RESUME` action to resume a paused or a deactivated
  /// subscription.
  @POST('/v2/subscriptions/{subscriptionId}/resume')
  Future<ResumeSubscriptionResponse> resumeSubscription({
    @Path() required String subscriptionId,
    @Body() required ResumeSubscriptionRequest request,
  });

  /// Schedules a `SWAP_PLAN` action to swap a subscription plan in an
  /// existing subscription.
  @POST('/v2//subscriptions/{subscriptionId}/swap-plan')
  Future<SwapPlanResponse> swapPlan({
    @Path() required String subscriptionId,
    @Body() required SwapPlanResponse request,
  });
}
